//
//  TimePickerField.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 5.10.21.
//

import UIKit
import SwiftUI

struct TimePickerField: UIViewRepresentable {
    
    private let textField = TextField()
    private let pickerView = UIPickerView()
    
    var data: [String]
    @Binding var lastSelectedIndex: Int
    
    func makeUIView(context: Context) -> some UITextField {
        pickerView.delegate = context.coordinator
        pickerView.dataSource = context.coordinator
        
        textField.inputView = pickerView

        return textField
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.text = data[lastSelectedIndex]
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(data: data) { index in
            lastSelectedIndex = index
        }
    }
    
    class Coordinator: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
        private var data: [String]
        private var didSelectItemAt: (Int) -> Void
        
        init(data: [String], didSelectItemAt: @escaping (Int) -> Void) {
            self.data = data
            self.didSelectItemAt = didSelectItemAt
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            1
        }
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            data.count
        }
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            data[row]
        }
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            didSelectItemAt(row)
        }
    }
}

fileprivate class TextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit() {
        setContentHuggingPriority(.required, for: .horizontal)
        inputAccessoryView = DoneToolbarButton { [weak self] in
            self?.resignFirstResponder()
        }
        borderStyle = .roundedRect
        backgroundColor = .tertiarySystemFill
        textAlignment = .center
    }
    override func caretRect(for position: UITextPosition) -> CGRect {
        .zero
    }
}
