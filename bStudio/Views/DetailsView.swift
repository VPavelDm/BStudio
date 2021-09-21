//
//  DetailsView.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 21.09.21.
//

import SwiftUI

struct DetailsView: View {
    @EnvironmentObject var orderDetails: OrderDetails
    
    var body: some View {
        HStack {
            VStack {
                content
                Spacer()
            }
            .padding(16)
            Spacer()
        }
        .background(Color.background.edgesIgnoringSafeArea([.bottom, .horizontal]))
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("VOSTOK'7")
        .navigationBarColor(backgroundColor: .woodsmoke, titleColor: .white)
    }
    private var content: some View {
        VStack(alignment: .leading) {
            title
            referenceContent
        }
    }
    private var title: some View {
        Text("Детали заказа")
            .font(.system(size: 34, weight: .regular))
            .foregroundColor(.white)
    }
    private var referenceContent: some View {
        VStack(alignment: .leading) {
            referenceTitle
            HStack(alignment: .top) {
                VStack {
                    ForEach(orderDetails.songs.indices, id: \.self) { index in
                        referenceInputs(text: $orderDetails.songs[index])
                    }
                }
                moreSongs
            }
        }
    }
    private var referenceTitle: some View {
        Text("Выберите референс")
            .font(.system(size: 20, weight: .semibold))
            .foregroundColor(.white)
    }
    private func referenceInputs(text: Binding<String>) -> some View {
        ZStack {
            TextField("", text: text)
                .textFieldStyle(StudioTextFieldStyle(when: text.wrappedValue.isEmpty) {
                    Text("Введите названия песни")
                        .foregroundColor(.white)
                })
        }
    }
    private var moreSongs: some View {
        Button {
            withAnimation {
                orderDetails.addNewSong()
            }
        } label: {
            RoundedButton(text: "Еще") {
                
            }
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailsView()
                .environmentObject(OrderDetails())
        }
    }
}
