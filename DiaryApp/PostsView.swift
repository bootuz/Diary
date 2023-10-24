//
//  PostsView.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 22.10.2023.
//

import SwiftUI

struct PostsView: View {
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Today's \(formatDate())")
                        .font(.subheadline)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding()
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        NavigationLink {
                            Text("Post name")
                        } label: {
                            HStack {
                                VStack(alignment: .leading, spacing: 5) {
                                    VStack(alignment: .leading) {
                                        Text("Post name")
                                        Text("First sentance of the post. Today something...")
                                            .lineLimit(1)
                                            .font(.footnote)
                                            .tint(.secondary)
                                    }
                                    HStack {
                                        Image(systemName: "globe")
                                        Label("10", systemImage: "hand.thumbsup")
                                        Label("21", systemImage: "bubble.left")
                                    }
                                    .font(.caption)
                                    .tint(.secondary)
                                }
                                Spacer()
                                Text("😞")
                            }
                        }
                        Divider()

                        NavigationLink {
                            Text("Post name")
                        } label: {
                            HStack {
                                VStack(alignment: .leading, spacing: 5) {
                                    VStack(alignment: .leading) {
                                        Text("Post name")
                                        Text("First sentance of the post. Today something...")
                                            .lineLimit(1)
                                            .font(.footnote)
                                            .tint(.secondary)
                                    }
                                    HStack {
                                        Image(systemName: "globe")
                                        Label("10", systemImage: "hand.thumbsup")
                                        Label("21", systemImage: "bubble.left")
                                    }
                                    .font(.caption)
                                    .tint(.secondary)
                                }
                                Spacer()
                                Text("😭")
                            }
                        }
                        Divider()

                        NavigationLink {
                            Text("Post name")
                        } label: {
                            HStack {
                                VStack(alignment: .leading, spacing: 5) {
                                    VStack(alignment: .leading) {
                                        Text("Post name")
                                        Text("First sentance of the post. Today something...")
                                            .lineLimit(1)
                                            .font(.footnote)
                                            .tint(.secondary)
                                    }
                                    HStack {
                                        Image(systemName: "globe")
                                        Label("10", systemImage: "hand.thumbsup")
                                        Label("21", systemImage: "bubble.left")
                                    }
                                    .font(.caption)
                                    .tint(.secondary)
                                }
                                Spacer()
                                Text("😄")
                            }
                        }
                        Divider()

                    }
                }
                .padding(.horizontal)
                Spacer()
            }
            .navigationTitle("My notes")
        }
    }

    private func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let dateString = dateFormatter.string(from: Date())
        return dateString
    }
}

#Preview {
    PostsView()
}
