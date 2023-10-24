//
//  AllMyNotesView.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 24.10.2023.
//

import SwiftUI

struct AllMyNotesView: View {

    @State private var viewModel = AllMyNotesViewModel(service: PostsService(client: BearerAuthDecorator(client: URLSession.shared)))

    var body: some View {
        List {
            ForEach(viewModel.allMyPosts) { post in
                NavigationLink {
                    Text("Test title")
                } label: {
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            VStack(alignment: .leading) {
                                HStack {
                                    Image(systemName: post.privateLevel.icon)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                    Text(post.title)
                                        .foregroundStyle(.blue)
                                }
                                Text(post.text)
                                    .lineLimit(1)
                                    .font(.footnote)
                                    .foregroundStyle(.secondary)
                            }
                            HStack {
                                HStack {
                                    Image(systemName: "hand.thumbsup")
                                    Text("10")
                                }
                                HStack {
                                    Image(systemName: "bubble.left")
                                    Text("\(post.commentCount)")
                                }
                            }
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .tint(.secondary)
                        }
                        Spacer()
                        Text(post.emotion.emoji)
                    }
                }
                .swipeActions(edge: .trailing) {
                    Button {
                        Task {
                            await viewModel.deletePost(id: post.id)
                        }
                    } label: {
                        Image(systemName: "trash")
                    }
                    .tint(.red)
                }
                .task {
                    if viewModel.hasReachedEnd(of: post) {
                        await viewModel.getNextMyPosts()
                    }
                }
            }
        }
        .opacity(viewModel.allMyPosts.isEmpty ? 0 : 1)
        .overlay(content: {
            if viewModel.allMyPosts.isEmpty {
                ContentUnavailableView(label: {
                    Label("No notes", systemImage: "square.and.pencil")
                }, description: {
                    Text("All your notes will appear here")
                }, actions: {
                    Button(action: {}) {
                        Text("Create note")
                    }
                    .buttonStyle(.bordered)
                })
                .opacity(viewModel.isLoading ? 0 : 1)
                .overlay {
                    if viewModel.isLoading {
                        ProgressView()
                    }
                }
            }
        })
        .listStyle(.plain)
        .refreshable {
            Task {
                await viewModel.getMyPosts(page: 0)
            }
        }
        .task {
            await viewModel.getMyPosts(page: 0)
        }
        .navigationTitle("My notes")
    }
}

#Preview {
    NavigationStack {
        AllMyNotesView()
    }
}
