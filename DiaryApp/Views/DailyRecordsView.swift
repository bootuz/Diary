//
//  NotesView.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 21.10.2023.
//

import SwiftUI

struct DailyRecordsView: View {
    @State private var showNewPostView: Bool = false
    @State private var showAllMyNotes: Bool = false
    @State private var viewModel = DailyRecordsViewModel(service: DailyRecordsService(client: BearerAuthDecorator(client: URLSession.shared)))
    @State private var filterEvents: String = "Week"

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HeaderView()
                        .padding()

                    HStack {
                        if let dailyRecords = viewModel.dailyRecords {
                            if !dailyRecords.myPosts.isEmpty {
                                VStack(alignment: .leading, spacing: 10) {
                                    ForEach(dailyRecords.myPosts) { post in
                                        PostRow(post: post)
                                    }
                                }
                                .font(.system(size: 20, weight: .regular))
                                .padding(.horizontal)
                            }
                            else {
                                PostsEmptyState()
                            }
                        } else {
                            PostsEmptyState()
                        }
                    }

                    HStack {
                        Text("Upcoming events")
                            .font(.subheadline)
                            .fontWeight(.bold)
                        Spacer()
                        MenuFilter()
                    }
                    .padding()

                    HStack {
                        EventsEmptyState()
                    }
                    Spacer()
                }
                .navigationTitle("Daily events")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            showNewPostView.toggle()
                        }, label: {
                            Image(systemName: "plus.circle.fill")
                        })
                        .sheet(isPresented: $showNewPostView) {
                            Text("New note view")
                        }
                    }
                }
                .task {
                    await viewModel.getDailyRecords()
            }
            }
        }
    }

    @ViewBuilder
    private func MenuFilter() -> some View {
        Menu {
            Button {
                filterEvents = "Day"
            } label: {
                Text("Day")
            }
            Button {
                filterEvents = "Month"
            } label: {
                Text("Month")
            }
            Button {
                filterEvents = "Week"
            } label: {
                Text("Week")
            }
        } label: {
            HStack {
                Text(filterEvents)
                Image(systemName: "chevron.down")
            }
        }
    }

    @ViewBuilder
    private func EventsEmptyState() -> some View {
        VStack {
            Text("No upcoming events")
                .font(.callout)
                .foregroundStyle(.secondary.opacity(0.6))

            Button(action: {

            }, label: {
                Text("Add event")
            })
            .sheet(isPresented: $showNewPostView, content: {
                Text("New event")
            })
            .buttonStyle(.bordered)
            .padding(.top, 8)
        }
    }

    @ViewBuilder
    private func PostsEmptyState() -> some View {
        VStack {
            Text("You didn't write any notes today")
                .font(.callout)
                .foregroundStyle(.secondary.opacity(0.6))

            Button(action: {

            }, label: {
                Text("Add note")
            })
            .sheet(isPresented: $showNewPostView, content: {
                Text("New Post")
            })
            .buttonStyle(.bordered)
            .padding(.top, 8)
        }
    }

    @ViewBuilder
    private func HeaderView() -> some View {
        HStack {
            Text("Today's \(viewModel.currentDate)")
                .font(.subheadline)
                .fontWeight(.bold)
            Spacer()
            Button(action: {
                showAllMyNotes.toggle()
            }, label: {
                Text("All my notes")
            })
            .navigationDestination(isPresented: $showAllMyNotes) {
                AllMyNotesView()
            }
        }
    }

    @ViewBuilder
    private func PostRow(post: MyPostDTO) -> some View {
        NavigationLink {
            Text(post.title)
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: post.privateLevel.icon)
                                .font(.subheadline)
                                .tint(.secondary)
                            Text(post.title)
                        }
                        Text(post.text)
                            .lineLimit(1)
                            .font(.footnote)
                            .tint(.secondary)
                    }
                    HStack {
                        Label("10", systemImage: "hand.thumbsup")
                        Label("\(post.commentCount)", systemImage: "bubble.left")
                    }
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .tint(.secondary)
                }
                Spacer()
                Text(post.emotion.emoji)
            }
        }
        Divider()
    }
}

#Preview {
    DailyRecordsView()
}
