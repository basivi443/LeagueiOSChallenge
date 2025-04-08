//
//  PostListViewModel.swift
//  LeagueiOSChallenge
//
//  Created by Basivi Reddy on 08/04/25.
//

import Foundation
struct PostListViewModelActions{
    let showPostListViewScreen : () -> Void
}

protocol PostListViewModelInput{
    func showPostListViewScreen()
}

protocol PostListViewModelOutput{

}

protocol PostListViewModel : PostListViewModelInput,PostListViewModelOutput{
    
}

class DefaultPostListViewModel : PostListViewModel{
   
    
    
    private let postListUseCase: PostListUseCase
    private let actions: PostListViewModelActions?
    
    init(postListUseCase: PostListUseCase, actions: PostListViewModelActions? = nil) {
        self.postListUseCase = postListUseCase
        self.actions = actions
    }
     
    func showPostListViewScreen() {
        actions?.showPostListViewScreen()
    }
}

