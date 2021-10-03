//
//  MixingDetailsView.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 27.09.21.
//

import SwiftUI

protocol MixingDetails: ObservableObject {
    var songs: [String] { get set }
    var suggestionsForWork: String { get set }
    var workTypes: [String] { get }
    var selectedWorkTypeIndex: Int { get set }
    var service: Service? { get set }
    
    func addNewSong()
}

struct MixingDetailsView<ViewModel>: View where ViewModel: MixingDetails {
    @EnvironmentObject private var mixingDetails: ViewModel
    @State private var shouldNavigateToNextScreen = false
    @State private var shouldShowNotFilledAlert = false
    var service: Service
    
    var body: some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.background.edgesIgnoringSafeArea([.bottom, .horizontal]))
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("VOSTOK'7")
            .navigationBarColor(backgroundColor: .woodsmoke, titleColor: .white)
            .alert(isPresented: $shouldShowNotFilledAlert) {
                Alert(title: Text("Вы не заполнили обязательные поля"),
                      message: Text("Для того, чтобы продолжить, Вам необходимо ввести хотя бы 1 название песни"),
                      dismissButton: .cancel(Text("Понятно")))
            }
            .onAppear {
                mixingDetails.service = service
            }

    }
    private var content: some View {
        VStack(alignment: .leading, spacing: 16) {
            title
            Group {
                referenceContent
                commentsContent
                workTypeContent
                next
            }
            .padding(.horizontal, 8)
            Spacer()
        }
        .padding(16)
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
                    ForEach(mixingDetails.songs.indices, id: \.self) { index in
                        referenceInputs(text: $mixingDetails.songs[index])
                    }
                }
                moreSongs
            }
        }
    }
    private var referenceTitle: some View {
        Text("Выберите референс*")
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
                mixingDetails.addNewSong()
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
                .opacity(mixingDetails.songs.count == 3 ? 0.5 : 1)
        }
        .disabled(mixingDetails.songs.count == 3)
    }
    
    // MARK: Comments
    private var commentsContent: some View {
        VStack(alignment: .leading, spacing: 8) {
            commentsTitle
            commentsInput(text: $mixingDetails.suggestionsForWork)
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
        RadioButtonPicker(values: mixingDetails.workTypes,
                          selectionIndex: $mixingDetails.selectedWorkTypeIndex) { text in
            Text(text)
                .font(.system(size: 20, weight: .regular))
                .foregroundColor(.textColor)
        }
    }
    
    // MARK: Next button
    private var next: some View {
        NavigationLink(destination: calendarView, isActive: $shouldNavigateToNextScreen) {
            RoundedButton(text: "Дальше") {
                if mixingDetails.songs.first?.isEmpty ?? true {
                    shouldShowNotFilledAlert = true
                } else {
                    shouldNavigateToNextScreen = true
                }
            }
        }
    }
    private var calendarView: some View {
        DayPickerView<MixingOrderDetails>()
    }
}

struct MixingDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MixingDetailsView<MixingOrderDetails>(service: .mixing)
                .environmentObject(MixingOrderDetails())
                .environmentObject(Studio())
        }
    }
}
