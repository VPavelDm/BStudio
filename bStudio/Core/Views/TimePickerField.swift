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
    
    var times: [WorkTime]
    @Binding var lastSelectedIndex: Int
    var timeIsChosen: () -> ()
    
    init(times: [WorkTime], lastSelectedIndex: Binding<Int>, timeIsChosen: @escaping () -> ()) {
        self.times = times
        self._lastSelectedIndex = lastSelectedIndex
        self.timeIsChosen = timeIsChosen
        self.textField.timeIsChosen = timeIsChosen
    }
    
    func makeUIView(context: Context) -> some UITextField {
        pickerView.delegate = context.coordinator
        pickerView.dataSource = context.coordinator
        
        textField.inputView = pickerView

        return textField
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.text = times[lastSelectedIndex].text
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(times: times) { index in
            lastSelectedIndex = index
        }
    }
    
    class Coordinator: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
        private var times: [WorkTime]
        private var didSelectItemAt: (Int) -> Void
        
        init(times: [WorkTime], didSelectItemAt: @escaping (Int) -> Void) {
            self.times = times
            self.didSelectItemAt = didSelectItemAt
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            1
        }
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            times.count
        }
        func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
            let label = UILabel()
            label.text = times[row].text
            label.textColor = times[row].isEnabled ? UIColor.label : UIColor.red
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 18, weight: .semibold)
            return label
        }
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            if times[row].isEnabled {
                didSelectItemAt(row)
            } else {
                for index in row..<times.count {
                    if times[index].isEnabled {
                        didSelectItemAt(index)
                        pickerView.selectRow(index, inComponent: 0, animated: true)
                        return
                    }
                }
                for index in stride(from: row, to: 0, by: -1) {
                    if times[index].isEnabled {
                        didSelectItemAt(index)
                        pickerView.selectRow(index, inComponent: 0, animated: true)
                        return
                    }
                }
            }
        }
    }
}

fileprivate class TextField: UITextField {
    var timeIsChosen: (() -> ())?

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
            self?.timeIsChosen?()
        }
        borderStyle = .roundedRect
        backgroundColor = .tertiarySystemFill
        textAlignment = .center
    }
    override func caretRect(for position: UITextPosition) -> CGRect {
        .zero
    }
}
