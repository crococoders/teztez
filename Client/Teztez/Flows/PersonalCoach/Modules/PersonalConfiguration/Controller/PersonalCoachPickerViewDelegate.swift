//
//  PersonalCoachPickerViewDelegate.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/1/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

private enum Constants {
    static let speedMeasure = "wpm"
}

final class PersonalCoachPickerViewDelegate: NSObject, UIPickerViewDelegate {
    private let store: PersonalCoachStore

    init(store: PersonalCoachStore) {
        self.store = store
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(store.speedList[row]) " + Constants.speedMeasure
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        store.dispatch(action: .didSelectSpeed(speed: store.speedList[row]))
    }
}
