//
//  FeedsStore.swift
//  Teztez
//
//  Created by Almas Zainoldin on 05/05/2020.
//  Copyright © 2020 Crococoders. All rights reserved.
//

import Foundation
import Models

final class FeedsStore {
    enum Action {
        case didLoadView
        case didSelectAt(index: Int)
    }

    enum State {
        case initial(items: [FeedsItemType])
        case infomrationSelected(details: InformationDetails)
    }

    @Published private(set) var state: State?
    private let provider: FeedsProvider
    private var items: [FeedsItemType] = []

    init() {
        provider = FeedsProvider()
    }

    func dispatch(action: Action) {
        switch action {
        case .didLoadView:
            fetchBlocks()
        case let .didSelectAt(index):
            setState(from: index)
        }
    }

    private func fetchBlocks() {
        provider.fetchFeeds { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(blocks):
                self.compileItems(from: blocks)
                self.state = .initial(items: self.items)
            case .failure:
                break
            }
        }
    }

    private func compileItems(from blocks: [Block]) {
        items.removeAll()
        blocks.forEach { block in
            switch block {
            case let .statistics(layoutType, model):
                switch layoutType {
                case .big:
                    items.append(.statisticsBig(viewModel: StatisticsSmallViewModel(block: model)))
                case .small:
                    items.append(.statisticsSmall(viewModel: StatisticsSmallViewModel(block: model)))
                case .long:
                    items.append(.statisticsLong(vieWModel: StatisticsLongViewModel(block: model)))
                case .huge:
                    break
                }
            case let .information(_, type):
                switch type {
                case let .headlined(date, model):
                    items.append(.informationHeadlined(viewModel: InformationHeadlinedViewModel(date: date, model: model)))
                case let .detailed(date, model):
                    items.append(.informationDetailed(viewModel: InformationDetailedViewModel(date: date, model: model)))
                }
            default:
                break
            }
        }
    }

    private func setState(from index: Int) {
        switch items[index] {
        case let .informationDetailed(viewModel):
            let details = InformationDetails(title: viewModel.title, metaTitle: viewModel.metaTitle, imageURL: viewModel.imageURL)
            state = .infomrationSelected(details: details)
        case let .informationHeadlined(viewModel):
            let details = InformationDetails(title: viewModel.title, metaTitle: viewModel.metaTitle, imageURL: viewModel.imageURL)
            state = .infomrationSelected(details: details)
        default:
            break
        }
    }
}
