//
//  TimePickerView.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 24.09.21.
//

import SwiftUI

struct TimePickerView: View {
    
    @State private var timeChooserIsPresented = false
    var title: String
    @Binding var selectedTime: String?
    var times: [String]
    
    var body: some View {
        content
            .onAppear {
                selectedTime = times.first
            }
    }
    private var content: some View {
        compactTimePickerView
            .overlay(timeChooserIsPresented ? timePickerPopupView.transition(timePickerPopupTransitionAnimation) : nil)
            .zIndex(1)
    }
    private var compactTimePickerView: some View {
        HStack {
            Text(title)
            Spacer()
            Button {
                withAnimation {
                    timeChooserIsPresented.toggle()
                }
            } label: {
                Text(selectedTime ?? "")
                    .font(.system(size: 17, weight: .regular))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 7)
                    .foregroundColor(.primary)
                    .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.tertiarySystemFill))
            }
        }
    }
    private var timePickerPopupView: some View {
        GeometryReader { geometry in
            Picker("", selection: $selectedTime) {
                ForEach(times, id: \.self) { time in
                    Text(time)
                        .foregroundColor(.black)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(maxWidth: 232, maxHeight: 204)
            .clipped()
            .background(
                Blur(style: .extraLight)
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.2), radius: 50)
            )
            .offset(x: geometry.size.width - (232 + 22),
                    y: geometry.size.height + 8)
        }
    }
    private var timePickerPopupTransitionAnimation: AnyTransition {
        .scale(scale: 0.01, anchor: .bottomTrailing)
    }
}

struct TimePickerView_Previews: PreviewProvider {
    static var previews: some View {
        TimePickerView(title: "Выберите время начала",
                       selectedTime: .constant("7:00"),
                       times: (6...23).map { "\($0):00" })
    }
}
