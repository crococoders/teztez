//
//  SliderView.swift
//  Teztez
//
//  Created by Adlet on 4/29/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

protocol SliderViewDelegate: class {
    func sliderView(_ sliderView: UISlider, didChangeFontSize fontSize: CGFloat)
}

final class SliderView: UIView, NibOwnerLoadable {
    weak var delegate: SliderViewDelegate?

    @IBOutlet private var slider: UISlider!

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
        setup()
    }

    @IBAction func changeTextSize(_ sender: UISlider) {
        let fontSize = roundf(sender.value)
        sender.setValue(fontSize, animated: false)
        delegate?.sliderView(sender, didChangeFontSize: CGFloat(fontSize))
    }

    private func setup() {
        backgroundColor = .systemGray2
    }

    func configure(with value: Float) {
        slider.value = value
    }
}
