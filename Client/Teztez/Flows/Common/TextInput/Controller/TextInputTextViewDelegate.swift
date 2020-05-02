//
//  TextInputTextViewDelegate.swift
//  Teztez
//
//  Created by Almas Zainoldin on 4/29/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

class TextInputTextViewDelegate: NSObject, UITextViewDelegate {
    private let store: TextInputStore

    init(store: TextInputStore) {
        self.store = store
    }

    func textViewDidChange(_ textView: UITextView) {
        guard !textView.text.isEmpty else {
            store.dispatch(action: .didResetText)
            return
        }
        store.dispatch(action: .didStartTextChange)
    }
}
