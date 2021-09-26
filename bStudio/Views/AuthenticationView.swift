//
//  AuthenticationView.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 24.09.21.
//

import SwiftUI

struct AuthenticationView: View {
    @EnvironmentObject private var orderDetails: OrderDetails
    
    var body: some View {
        VStack(alignment: .leading){
            title
            Spacer()
            content.padding(8)
            Spacer()
        }
        .padding(16)
        .background(Color.background.edgesIgnoringSafeArea([.bottom, .horizontal]))
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("VOSTOK'7")
        .navigationBarColor(backgroundColor: .woodsmoke, titleColor: .white)
    }
    private var title: some View {
        Text("Личные данные")
            .font(.system(size: 34, weight: .regular))
            .foregroundColor(.textColor)
    }
    private var content: some View {
        VStack(spacing: 16) {
            nameTextField
            phoneNumberTextField
            commentsTextField
            makeOrder
        }
    }
    private var nameTextField: some View {
        TextField("Введите имя*", text: $orderDetails.clientName)
            .textFieldStyle(StudioTextFieldStyle(when: orderDetails.clientName.isEmpty) {
                Text("Введите имя*")
                    .foregroundColor(.white.opacity(0.6))
            })
    }
    private var phoneNumberTextField: some View {
        TextField("Введите номер телефона*", text: $orderDetails.clientPhoneNumber)
            .textFieldStyle(StudioTextFieldStyle(when: orderDetails.clientPhoneNumber.isEmpty) {
                Text("Введите номер телефона*")
                    .foregroundColor(.white.opacity(0.6))
            })
    }
    private var commentsTextField: some View {
        TextField("Напишите любые комментарии*", text: $orderDetails.comments)
            .textFieldStyle(StudioTextFieldStyle(when: orderDetails.comments.isEmpty) {
                Text("Напишите любые комментарии*")
                    .foregroundColor(.white.opacity(0.6))
            })
    }
    private var makeOrder: some View {
        RoundedButton(text: "Записаться") {
            print(orderDetails)
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AuthenticationView()
                .environmentObject(OrderDetails())
        }
    }
}
