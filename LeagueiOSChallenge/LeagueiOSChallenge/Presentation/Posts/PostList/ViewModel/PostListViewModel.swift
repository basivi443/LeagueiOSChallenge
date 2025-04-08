//
//  PostListViewModel.swift
//  LeagueiOSChallenge
//
//  Created by Basivi Reddy on 08/04/25.
//

import Foundation
struct NotesViewModelActions{
    let showNotesEditScreen : (String,Bool) -> Void
}

protocol PostListViewModelInput{
    
}

protocol PostListViewModelOutput{

}

protocol PostListViewModel : PostListViewModelInput,PostListViewModelOutput{
    
}

class DefaultPostListViewModel : PostListViewModel{
    
    private let postListUseCase: PostListUseCase
    
    init(postListUseCase: PostListUseCase) {
        self.postListUseCase = postListUseCase
    }
     
}

