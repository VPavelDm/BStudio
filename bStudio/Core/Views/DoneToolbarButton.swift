//
//  DoneToolbarButton.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 5.10.21.
//

import UIKit

public class DoneToolbarButton: UIToolbar {
    private var completion: (() -> Void)?
    
    public init(completion: @escaping () -> Void) {
        super.init(frame: .zero)
        
        self.completion = completion
        
        barStyle = .default
        items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                            target: nil,
                            action: nil),
            UIBarButtonItem(barButtonSystemItem: .done,
                            target: self,
                            action: #selector(didTapButton))
            ]
        sizeToFit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapButton() {
        completion?()
    }
}
