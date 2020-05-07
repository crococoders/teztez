//
//  ColorMatchingPickerViewDataSource.swift
//  Teztez
//
//  Created by Adlet on 5/3/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

private enum Constants {
    static let numberOfComponents = 1
}

final class ColorMatchingPickerViewDataSource: NSObject, UIPickerViewDataSource {
    private let store: ColorMatchingConfigurationStore

    init(store: ColorMatchingConfigurationStore) {
        self.store = store
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        Constants.numberOfComponents
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        store.durationList.count
    }
}
