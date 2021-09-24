//
//  DetailsView.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 21.09.21.
//

import SwiftUI

struct DetailsView: View {
    @EnvironmentObject var orderDetails: OrderDetails
    @State private var shouldNavigateToNextScreen = false
    
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
        VStack(alignment: .leading, spacing: 16) {
            title
            Group {
                referenceContent
                commentsContent
                workTypeContent
                next
            }.padding(.horizontal, 8)
        }
    }
    private var title: some View {
        Text("Детали заказа")
            .font(.system(size: 34, weight: .regular))
            .foregroundColor(.white)
    }
    
    // MARK: Reference content
    private var referenceContent: some View {
        VStack(alignment: .leading, spacing: 8) {
            referenceTitle
            HStack(alignment: .top, spacing: 8) {
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
        TextField("", text: text)
            .textFieldStyle(StudioTextFieldStyle(when: text.wrappedValue.isEmpty) {
                Text("Введите названия песни")
                    .foregroundColor(.white.opacity(0.6))
            })
    }
    private var moreSongs: some View {
        Button {
            withAnimation {
                orderDetails.addNewSong()
            }
        } label: {
            Text("Ещё")
                .font(.system(size: 20, weight: .semibold))
                .padding(.vertical, 7)
                .padding(.horizontal, 16)
                .foregroundColor(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.xanadu, lineWidth: 2)
                )
                .opacity(orderDetails.songs.count == 3 ? 0.5 : 1)
        }
        .disabled(orderDetails.songs.count == 3)
    }
    
    // MARK: Comments
    private var commentsContent: some View {
        VStack(alignment: .leading, spacing: 8) {
            commentsTitle
            commentsInput(text: $orderDetails.comments)
        }
    }
    private var commentsTitle: some View {
        Text("Напишите пожелания к результату работы")
            .font(.system(size: 20, weight: .semibold))
            .foregroundColor(.white)
    }
    private func commentsInput(text: Binding<String>) -> some View {
        TextField("", text: text)
            .textFieldStyle(StudioTextFieldStyle(when: text.wrappedValue.isEmpty) {
                Text("Оставьте любые комментарии")
                    .foregroundColor(.white.opacity(0.6))
            })
    }
    
    // MARK: - Work type
    private var workTypeContent: some View {
        VStack(alignment: .leading, spacing: 8) {
            workTypeTitle
            workTypePicker
        }
    }
    private var workTypeTitle: some View {
        Text("Выберите вариант работы*")
            .font(.system(size: 20, weight: .semibold))
            .foregroundColor(.white)
    }
    private var workTypePicker: some View {
        RadioButtonPicker(values: orderDetails.workTypes,
                          selectionIndex: $orderDetails.selectedWorkTypeIndex) { text in
            Text(text)
                .font(.system(size: 20, weight: .regular))
                .foregroundColor(.textColor)
        }
    }
    
    // MARK: Next button
    private var next: some View {
        NavigationLink(destination: Text("Hello"), isActive: $shouldNavigateToNextScreen) {
            RoundedButton(text: "Дальше") {
                shouldNavigateToNextScreen = true
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
