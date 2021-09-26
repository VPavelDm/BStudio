//
//  AuthorListView.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 17.09.21.
//

import SwiftUI

struct AuthorListView: View {
    @StateObject private var authorList = AuthorList()
    @State private var isAuthorListLoaded = false
    @State private var shouldShowMusicExamplesScreen = false
    @State private var shouldShowNextScreen = false
    
    var body: some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.background.edgesIgnoringSafeArea([.bottom, .horizontal]))
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("VOSTOK'7")
            .navigationBarColor(backgroundColor: .woodsmoke, titleColor: .white)
            .onAppear {
                authorList.loadAuthorList()
            }
            .onReceive(authorList.$authors) { authorList in
                withAnimation {
                    isAuthorListLoaded = !authorList.isEmpty
                }
            }
    }
    
    private var content: some View {
        ZStack {
            if isAuthorListLoaded {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 16) {
                        title
                        ForEach(authorList.authors) { author in
                            card(for: author).padding(.leading, 8)
                        }
                    }
                    .padding(16)
                }
            } else {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .xanadu))
            }
        }
    }
    private var title: some View {
        Text("Выберите автора")
            .font(.system(size: 34, weight: .regular))
            .foregroundColor(.white)
    }
    private func card(for author: Author) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top, spacing: 16) {
                image(author.imageURL)
                VStack(alignment: .leading, spacing: 8) {
                    name(author.name)
                    VStack(spacing: 0) {
                        ForEach(author.arrangements) { arrangement in
                            description(arrangement)
                        }
                    }
                }
            }
            choose
            listen(author: author)
        }
    }
    private func image(_ url: URL) -> some View {
        AsyncImage(url: url)
            .frame(width: 132, height: 132)
            .cornerRadius(8)
    }
    private func name(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 24, weight: .semibold))
            .foregroundColor(.white)
    }
    private func description(_ arrangement: Arrangement) -> some View {
        HStack {
            Text(arrangement.name)
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .regular))
            Spacer()
            Text(arrangement.price)
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .regular))
        }
    }
    private var choose: some View {
        NavigationLink(destination: detailsView, isActive: $shouldShowNextScreen) {
            RoundedButton(text: "Выбрать") {
                shouldShowNextScreen = true
            }
        }
    }
    private var detailsView: some View {
        DetailsView()
            .environmentObject(OrderDetails())
    }
    private func listen(author: Author) -> some View {
        NavigationLink(destination: MusicListView(songs: author.songs), isActive: $shouldShowMusicExamplesScreen) {
            Button {
                shouldShowMusicExamplesScreen = true
            } label: {
                Text("Слушать примеры работ")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.xanadu)
                    .font(.system(size: 20, weight: .semibold))
            }
        }
    }
}

struct AuthorListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AuthorListView()
        }
    }
}
