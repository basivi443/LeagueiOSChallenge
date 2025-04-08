//
//  PostListUseCase.swift
//  LeagueiOSChallenge
//
//  Created by Basivi Reddy on 08/04/25.
//

protocol PostListUseCase{
    
}

class DefaultPostListUseCase: PostListUseCase{
    private var postListRepository: PostListRepository
    
    init(postListRepository: PostListRepository) {
        self.postListRepository = postListRepository
    }
}
