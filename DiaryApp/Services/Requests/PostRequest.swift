//
//  PostRequest.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 24.10.2023.
//

import Foundation

enum PostRequest {
    case update(post: PostUpdateDTO)
    case setReaction(reaction: ReactionDTO)
    case create(post: PostCreateDTO)
    case removeReaction(postId: Int)
    case reactions(postId: Int, pageable: Pageable)
    case getPostsOf(id: Int, pageable: Pageable)
    case getPost(id: Int)
    case getMyPosts(pageable: Pageable)
    case deletePost(id: Int)
}

extension PostRequest: Request {
    var path: String {
        switch self {
            case .update:
                return "\(Constants.basePath)/post/update"
            case .setReaction:
                return "\(Constants.basePath)/post/setReaction"
            case .create:
                return "\(Constants.basePath)/post/create"
            case .removeReaction:
                return "\(Constants.basePath)/post/removeReaction"
            case .reactions:
                return "\(Constants.basePath)/post/reactions"
            case .getPostsOf(let id, _):
                return "\(Constants.basePath)/post/getPostsOf/\(id)"
            case .getPost(let id):
                return "\(Constants.basePath)/post/getPost/\(id)"
            case .getMyPosts:
                return "\(Constants.basePath)/post/getMyPosts"
            case .deletePost(let id):
                return "\(Constants.basePath)/post/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
            case .update, .setReaction, .create:
                return .POST
            case .removeReaction, .reactions, .getPostsOf, .getPost, .getMyPosts:
                return .GET
            case .deletePost:
                return .DELETE
        }
    }
    
    var header: [String: String]? {
        return nil
    }
    
    var body: [String: Any]? {
        switch self {
            case .update(let post):
                return post.toDictionary()
            case .setReaction(let reaction):
                return reaction.toDictionary()
            case .create(let post):
                return post.toDictionary()
            default:
                return nil
        }
    }
    
    var query: [URLQueryItem]? {
        switch self {
            case .removeReaction(let postId):
                return [URLQueryItem(name: "postId", value: String(postId))]
            case .reactions(let postId, let pageable):
                var array = pageable.toQueryItemArray()
                array.append(URLQueryItem(name: "postId", value: String(postId)))
                return array
            case .getPostsOf(_, let pageable):
                return pageable.toQueryItemArray()
            case .getMyPosts(let pageable):
                return pageable.toQueryItemArray()
            default:
                return nil
        }
    }
}
