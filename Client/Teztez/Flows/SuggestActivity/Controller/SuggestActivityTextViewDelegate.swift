//
//  SuggestActivityTextViewDelegate.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/5/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

class SuggestActivtityTextViewDelegate: NSObject, UITextViewDelegate {
    private let store: SuggestActivityStore

    init(store: SuggestActivityStore) {
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
