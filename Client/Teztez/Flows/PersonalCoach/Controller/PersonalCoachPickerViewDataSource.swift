//
//  PersonalCoachPickerViewDataSource.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/1/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class PersonalCoachPickerViewDataSource: NSObject, UIPickerViewDataSource {
    private let store: PersonalCoachStore

    init(store: PersonalCoachStore) {
        self.store = store
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        store.speedList.count
    }
}
