//
//  ArrangementDetailsView.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 21.09.21.
//

import SwiftUI

protocol ArrangementDetails: ObservableObject {
    var songs: [String] { get set }
    var suggestionsForWork: String { get set }
    var workTypes: [String] { get }
    var selectedWorkTypeIndex: Int { get set }
    var demoURL: URL? { get set }
    
    func addNewSong()
}

struct ArrangementDetailsView<ViewModel>: View where ViewModel: ArrangementDetails {
    @EnvironmentObject private var arrangementDetails: ViewModel
    @State private var shouldNavigateToNextScreen = false
    @State private var shouldShowNotFilledAlert = false
    @State private var shouldShowDocumentsScreen = false
    
    var body: some View {
        ScrollView {
            content
        }
        .bStudioNavigationBar(title: "VOSTOK'7")
        .alert(isPresented: $shouldShowNotFilledAlert) {
            Alert(title: Text("Вы не заполнили обязательные поля"),
                  message: Text("Для того, чтобы продолжить, Вам необходимо ввести хотя бы 1 название песни"),
                  dismissButton: .cancel(Text("Понятно")))
        }
        .sheet(isPresented: $shouldShowDocumentsScreen) {
            DocumentsPickerView(fileURL: $arrangementDetails.demoURL)
        }
    }
    private var content: some View {
        VStack(alignment: .leading, spacing: 16) {
            title
            Group {
                referenceContent
                demoContent
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
                VStack(alignment: .leading, spacing: 2) {
                    VStack {
                        ForEach(arrangementDetails.songs.indices, id: \.self) { index in
                            referenceInputs(text: $arrangementDetails.songs[index])
                        }
                    }
                    Text("Вы также можете вставить ссылку на песню")
                        .foregroundColor(.white.opacity(0.6))
                        .font(.system(size: 14))
                        .padding(.horizontal, 12)
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
                Text("Введите название песни")
                    .foregroundColor(.white.opacity(0.6))
            })
    }
    private var moreSongs: some View {
        Button {
            withAnimation {
                arrangementDetails.addNewSong()
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
                .opacity(arrangementDetails.songs.count == 3 ? 0.5 : 1)
        }
        .disabled(arrangementDetails.songs.count == 3)
    }
    
    // MARK: Demo
    private var demoContent: some View {
        VStack(alignment: .leading, spacing: 8) {
            demoTitle
            demoInput
        }
    }
    private var demoTitle: some View {
        Text("Добавьте демо")
            .font(.system(size: 20, weight: .semibold))
            .foregroundColor(.white)
    }
    private var demoInput: some View {
        Button {
            shouldShowDocumentsScreen = true
        } label: {
            HStack {
                Text(arrangementDetails.demoURL?.lastPathComponent ?? "")
                Spacer()
                Image(systemName: "paperclip")
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .overlay(RoundedRectangle(cornerRadius: 6).strokeBorder(lineWidth: 1))
            .foregroundColor(.white)
        }
    }
    
    // MARK: Comments
    private var commentsContent: some View {
        VStack(alignment: .leading, spacing: 8) {
            commentsTitle
            commentsInput(text: $arrangementDetails.suggestionsForWork)
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
        RadioButtonPicker(values: arrangementDetails.workTypes,
                          selectionIndex: $arrangementDetails.selectedWorkTypeIndex) { text in
            Text(text)
                .font(.system(size: 20, weight: .regular))
                .foregroundColor(.textColor)
        }
    }
    
    // MARK: Next button
    private var next: some View {
        NavigationLink(destination: calendarView, isActive: $shouldNavigateToNextScreen) {
            RoundedButton(text: "Дальше") {
                if arrangementDetails.songs.first?.isEmpty ?? true {
                    shouldShowNotFilledAlert = true
                } else {
                    shouldNavigateToNextScreen = true
                }
            }
        }
    }
    private var calendarView: some View {
        DayPickerView<ArrangementOrderDetails>()
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ArrangementDetailsView<ArrangementOrderDetails>()
                .environmentObject(ArrangementOrderDetails())
                .environmentObject(Studio())
        }
    }
}
