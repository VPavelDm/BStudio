//
//  ServicesViewModel.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 26.09.21.
//

import Foundation

class ServicesViewModel: ObservableObject {
    @Published private(set) var services: [Service] = []
    var isServicesLoaded: Bool { !services.isEmpty }
    
    func loadServices() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(0)) { [weak self] in
            self?.services = [
                .init(id: 0, name: "Написание аранжировки", steps: []),
                .init(id: 1, name: "Запись вокала", steps: []),
                .init(id: 2, name: "Сведение", steps: []),
                .init(id: 3, name: "Мастеринг", steps: [])
            ]
        }
    }
}
