//
//  DocumentsPickerView.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 8.10.21.
//

import UIKit
import SwiftUI

struct DocumentsPickerView: UIViewControllerRepresentable {
    
    // MARK: - UIViewControllerRepresentable
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let controller = UIDocumentPickerViewController(forOpeningContentTypes: [.text], asCopy: true)
        controller.delegate = context.coordinator
        return controller
    }
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {
    }
    
    // MARK: - Coordinator
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    class Coordinator: NSObject, UIDocumentPickerDelegate, UINavigationBarDelegate {
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            print(urls)
        }
    }
}
