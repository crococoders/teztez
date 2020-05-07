//
//  ColorMatchingPickerViewDelegate.swift
//  Teztez
//
//  Created by Adlet on 5/3/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

private enum Constants {
    static let durationMeasure = "s"
}

final class ColorMatchingPickerViewDelegate: NSObject, UIPickerViewDelegate {
    private let store: ColorMatchingConfigurationStore

    init(store: ColorMatchingConfigurationStore) {
        self.store = store
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(store.durationList[row])" + Constants.durationMeasure
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        store.dispatch(action: .didSelectDuration(duration: store.durationList[row]))
    }
}
