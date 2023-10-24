//
//  PostsService.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 24.10.2023.
//

import Foundation

class PostsService {
    private var client: HTTPClient

    init(client: HTTPClient) {
        self.client = client
    }

    func update(post: PostUpdateDTO) async throws -> Response<MyPostDTO> {
        let (data, response) = try await client.perform(request: PostRequest.update(post: post).urlRequest)
        return try ResponseMapper.map(data: data, response: response)
    }

    func setReaction(reaction: ReactionDTO) async throws -> Response<String> {
        let (data, response) = try await client.perform(request: PostRequest.setReaction(reaction: reaction).urlRequest)
        return try ResponseMapper.map(data: data, response: response)
    }
    
    func create(post: PostCreateDTO) async throws -> Response<MyPostDTO> {
        let (data, response) = try await client.perform(request: PostRequest.create(post: post).urlRequest)
        return try ResponseMapper.map(data: data, response: response)
    }

    func removeReaction(postId: Int) async throws -> Response<String> {
        let (data, response) = try await client.perform(request: PostRequest.removeReaction(postId: postId).urlRequest)
        return try ResponseMapper.map(data: data, response: response)
    }

    func reactions(postId: Int, pageable: Pageable) async throws -> Response<PageDTO<ReactionsContentDTO>> {
        let (data, response) = try await client.perform(request: PostRequest.reactions(postId: postId, pageable: pageable).urlRequest)
        return try ResponseMapper.map(data: data, response: response)
    }
    
    // TODO: - NOT YET IMPLEMENTED
    func getPostsOf(id: Int, pageable: Pageable) async throws -> Response<String> { // Return type will be changed
        let (data, response) = try await client.perform(request: PostRequest.getPostsOf(id: id, pageable: pageable).urlRequest)
        return try ResponseMapper.map(data: data, response: response)
    }

    func getPost(id: Int) async throws -> Response<MyPostDTO> {
        let (data, response) = try await client.perform(request: PostRequest.getPost(id: id).urlRequest)
        return try ResponseMapper.map(data: data, response: response)
    }
    
    func getMyPosts(pageable: Pageable) async throws -> Response<PageDTO<MyPostDTO>> {
        let (data, response) = try await client.perform(request: PostRequest.getMyPosts(pageable: pageable).urlRequest)
        return try ResponseMapper.map(data: data, response: response)
    }

    func deletePost(id: Int) async throws -> Response<String> {
        let (data, response) = try await client.perform(request: PostRequest.deletePost(id: id).urlRequest)
        return try ResponseMapper.map(data: data, response: response)
    }
}
