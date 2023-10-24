//
//  AllMyNotesViewModel.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 24.10.2023.
//

import Foundation

@Observable
class AllMyNotesViewModel {
    private var service: PostsService

    var allMyPosts: [MyPostDTO] = [MyPostDTO]()
    var isLoading: Bool = false

    private var page: Int = 0

    init(service: PostsService) {
        self.service = service
    }
    
    @MainActor
    func getMyPosts(page: Int, size: Int? = nil, sort: [String]? = ["createdDateTime"]) async {
        isLoading = true
        defer { isLoading = false }
        let pageable = Pageable(page: page, size: size, sort: sort)
        do {
            let myPosts = try await service.getMyPosts(pageable: pageable)
            guard let allPosts = myPosts.body?.content else { return }
            allMyPosts += allPosts
        } catch {
            print(error)
        }
    }

    @MainActor
    func getNextMyPosts() async {
        page += 1
        await getMyPosts(page: page)
    }

    @MainActor
    func deletePost(id: Int) async {
        do {
            allMyPosts.removeAll { $0.id == id }
            let _ = try await service.deletePost(id: id)
        } catch {
            print(error)
        }
    }

    func hasReachedEnd(of post: MyPostDTO) -> Bool {
        return allMyPosts.last?.id == post.id
    }

}
