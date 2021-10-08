//
//  AuthenticationView.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 24.09.21.
//

import SwiftUI

protocol AuthenticationDetails: ObservableObject {
    var clientName: String { get set }
    var clientPhoneNumber: String { get set }
    var comments: String { get set }
    
    func createParamsForRequest() -> [String: Any]
}

struct AuthenticationView<ViewModel>: View where ViewModel: AuthenticationDetails {
    @EnvironmentObject private var authenticationDetails: ViewModel
    @EnvironmentObject private var studio: Studio
    @EnvironmentObject private var bookingNavigation: BookingNavigation
    @State private var notFilledFieldErrorMessage: IdentifiableString?
    @State private var makeOrderError = false
    @State private var makeOrderRequestIsWorking = false
    @State private var shouldShowSuccessAlert = false
    
    var body: some View {
        VStack(alignment: .leading){
            title
            Spacer()
            content.padding(8)
            Spacer()
        }
        .padding(16)
        .bStudioNavigationBar(title: "VOSTOK'7")
        .alert(item: $notFilledFieldErrorMessage) { message in
            Alert(title: Text("Вы не заполнили обязательные поля"),
                  message: Text(message.text),
                  dismissButton: .cancel(Text("Понятно")))
        }
        .alert(isPresented: $makeOrderError) {
            Alert(title: Text("Что-то пошло не так :c"),
                  message: Text("Мы уже работаем над тем, чтобы исправить ошибку! Попробуйте осуществить запись снова позже"),
                  primaryButton: .default(Text("Попробовать еще раз"),
                                          action: tryToMakeOrder),
                  secondaryButton: .cancel(Text("Понятно")))
        }
        .alert(isPresented: $shouldShowSuccessAlert) {
            Alert(
                title: Text("Ура! 🎶"),
                message: Text("Запись прошла успешно! Ждем Вас в нашей студии"),
                dismissButton: .default(Text("Понятно")) {
                    bookingNavigation.isBookingUnderway = false
                }
            )
        }
    }
    private var activityIndicator: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .xanadu))
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
            ZStack {
                makeOrderButton.opacity(makeOrderRequestIsWorking ? 0 : 1)
                activityIndicator.opacity(makeOrderRequestIsWorking ? 1 : 0)
            }
        }
    }
    private var nameTextField: some View {
        TextField("Введите имя*", text: $authenticationDetails.clientName)
            .textFieldStyle(StudioTextFieldStyle(when: authenticationDetails.clientName.isEmpty) {
                Text("Введите имя*")
                    .foregroundColor(.white.opacity(0.6))
            })
    }
    private var phoneNumberTextField: some View {
        TextField("Введите номер телефона*", text: $authenticationDetails.clientPhoneNumber)
            .textFieldStyle(StudioTextFieldStyle(when: authenticationDetails.clientPhoneNumber.isEmpty) {
                Text("Введите номер телефона*")
                    .foregroundColor(.white.opacity(0.6))
            })
    }
    private var commentsTextField: some View {
        TextField("Напишите любые комментарии", text: $authenticationDetails.comments)
            .textFieldStyle(StudioTextFieldStyle(when: authenticationDetails.comments.isEmpty) {
                Text("Напишите любые комментарии")
                    .foregroundColor(.white.opacity(0.6))
            })
    }
    private var makeOrderButton: some View {
        RoundedButton(text: "Записаться") {
            tryToMakeOrder()
        }
    }
    private func tryToMakeOrder() {
        if authenticationDetails.clientName.isEmpty {
            notFilledFieldErrorMessage = .init(text: "Для того, чтобы продолжить, Вам необходимо ввести Ваше имя")
        } else if authenticationDetails.clientPhoneNumber.isEmpty {
            notFilledFieldErrorMessage = .init(text: "Для того, чтобы продолжить, Вам необходимо ввести Ваш номер телефона")
        } else {
            makeOrderRequestIsWorking = true
            studio.makeReservation(params: authenticationDetails.createParamsForRequest()) { result in
                makeOrderRequestIsWorking = false
                switch result {
                case .success:
                    shouldShowSuccessAlert = true
                case .failure:
                    makeOrderError = true
                }
            }
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AuthenticationView<ArrangementOrderDetails>()
                .environmentObject(ArrangementOrderDetails())
        }
    }
}
