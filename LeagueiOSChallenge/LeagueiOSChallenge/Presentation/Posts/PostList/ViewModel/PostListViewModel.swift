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
    func viewDidLoad()
}

protocol PostListViewModelOutput{
    var error: Observable<String> { get }
    var logoutTitle: Observable<String> {get}
    var users:[UserDTO] {get set}
    var loading: Observable<Bool> {get}
    var isGuest: Observable<Bool> {get}
}

protocol PostListViewModel : PostListViewModelInput,PostListViewModelOutput{
    
}

class DefaultPostListViewModel : PostListViewModel{
   
    
    
    private let postListUseCase: PostListUseCase
    private let actions: PostListViewModelActions?
    private var moviesLoadTask: Cancellable? { willSet { moviesLoadTask?.cancel() } }
    private let mainQueue: DispatchQueueType
    let error: Observable<String> = Observable("")
    let logoutTitle: Observable<String> = Observable("")
    var loading: Observable<Bool> = Observable(false)
    var isGuest: Observable<Bool> = Observable(false)

     var users: [UserDTO] = []

    
    init(postListUseCase: PostListUseCase, actions: PostListViewModelActions? = nil, mainQueue: DispatchQueueType = DispatchQueue.main) {
        self.postListUseCase = postListUseCase
        self.actions = actions
        self.mainQueue = mainQueue
    }
     
    func showPostListViewScreen() {
        actions?.showPostListViewScreen()
    }
    
    func viewDidLoad() {
        moviesLoadTask = postListUseCase.execute(
            completion: { [weak self] result in
                self?.mainQueue.async {
                    switch result {
                    case .success(let page):
                        self?.users = page
                        self?.loading.value = false
                    case .failure(let error):
                        self?.handle(error: error)
                        self?.loading.value = false
                    }
                }
        })
    }
    
    private func handle(error: Error) {
        self.error.value = error.isInternetConnectionError ?
            NSLocalizedString("No internet connection", comment: "") :
            NSLocalizedString("Failed loading movies", comment: "")
    }
}

