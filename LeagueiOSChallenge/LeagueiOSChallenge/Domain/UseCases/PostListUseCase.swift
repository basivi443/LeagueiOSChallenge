//
//  PostListUseCase.swift
//  LeagueiOSChallenge
//
//  Created by Basivi Reddy on 08/04/25.
//

import Foundation

protocol PostListUseCase{
    func execute(completion: @escaping (Result<[UserDTO], Error>) -> Void
    ) -> Cancellable?

}

class DefaultPostListUseCase: PostListUseCase{
    private var postListRepository: PostListRepository
    
    init(postListRepository: PostListRepository) {
        self.postListRepository = postListRepository
    }
    
    func execute(completion: @escaping (Result<[UserDTO], Error>) -> Void
    ) -> Cancellable? {

        return postListRepository.fetchUsers(
            completion: { result in
            completion(result)
        })
    }
}
