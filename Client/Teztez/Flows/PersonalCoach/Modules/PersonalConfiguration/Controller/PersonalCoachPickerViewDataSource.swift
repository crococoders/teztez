//
//  PersonalCoachPickerViewDataSource.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/1/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

private enum Constants {
    static let numberOfComponents = 1
}

final class PersonalCoachPickerViewDataSource: NSObject, UIPickerViewDataSource {
    private let store: PersonalCoachStore

    init(store: PersonalCoachStore) {
        self.store = store
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        Constants.numberOfComponents
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        store.speedList.count
    }
}
