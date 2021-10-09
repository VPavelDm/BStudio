//
//  DocumentsPickerView.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 8.10.21.
//

import UIKit
import SwiftUI
import UniformTypeIdentifiers

struct DocumentsPickerView: UIViewControllerRepresentable {
    @Binding var fileURL: URL?
    
    // MARK: - UIViewControllerRepresentable
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let types: [UTType] = [.audio]
        let controller = UIDocumentPickerViewController(forOpeningContentTypes: types, asCopy: true)
        controller.delegate = context.coordinator
        return controller
    }
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {
    }
    
    // MARK: - Coordinator
    func makeCoordinator() -> Coordinator {
        Coordinator(fileURL: $fileURL)
    }
    class Coordinator: NSObject, UIDocumentPickerDelegate, UINavigationBarDelegate {
        @Binding var fileURL: URL?
        
        init(fileURL: Binding<URL?>) {
            self._fileURL = fileURL
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let url = urls.first else { return }
            fileURL = url
        }
    }
}
