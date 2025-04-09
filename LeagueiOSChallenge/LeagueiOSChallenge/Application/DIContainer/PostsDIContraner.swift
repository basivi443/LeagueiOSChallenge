//
//  PostsDIContraner.swift
//  LeagueiOSChallenge
//
//  Created by Basivi Reddy on 08/04/25.
//
import UIKit

final class PostsDIContraner: PostsFlowCoordinatorDependencies{
   
    struct Dependencies {
        let apiDataTransferService: DataTransferService
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    lazy var userResponseCache: UserResponse = ResponseStorage()
    
    
    // MARK: - Post List
    func makePostListUseCase() -> PostListUseCase {
        DefaultPostListUseCase(
            postListRepository: makePostRepository()
        )
    }
    
    func makePostRepository() -> PostListRepository{
        DefaultPostlistRepository(dataTransferService: dependencies.apiDataTransferService, cache: userResponseCache)
    }
    func makePostListViewModel(action: PostListViewModelActions) -> PostListViewModel {
        DefaultPostListViewModel(
            postListUseCase: makePostListUseCase(),
            actions: action
        )
    }
    
    func makePostListViewController(actions action: PostListViewModelActions) -> PostListViewController {
        PostListViewController.create(with: makePostListViewModel(action: action), storyBoardName: PostsDIContraner.storyBoard)
    }
    
    //MARK: Login
    func makeLoginViewModel(action: LoginViewModelActions)-> LoginViewModel{
        DefaultLoginViewModel(actions: action)
    }
    
    func makeLoginViewController(actions action: LoginViewModelActions) -> LoginViewController {
        LoginViewController.create(with: makeLoginViewModel(action: action), storyBoardName: PostsDIContraner.storyBoard)
    }
    
    
    
    // MARK: - Post Details
    func makePostDetailsUseCase() -> PostDetailsUseCase {
        DefaultPostDetailsUseCase(
            postDetailsRepository: makePostDetailsRepository()
        )
    }
    
    // MARK: - Repositories
    func makePostDetailsRepository() -> PostDetailsRepository{
        DefaultPostDetailsRepository()
    }
    func makePostDetailstViewModel() -> PostDetailsViewModel {
        DefaultPostDetailsViewModel(
            PostDetailsUseCase: makePostDetailsUseCase()
        )
    }
    
    func makePostDetailsViewController() -> PostDetailsViewController {
        PostDetailsViewController.create(with: makePostDetailstViewModel(), storyBoardName: PostsDIContraner.storyBoard)
    }
    
    
    
    // MARK: - Flow Coordinators
    func makePostsFlowCoordinator(navigationController: UINavigationController) -> PostsFlowCoordinator {
        PostsFlowCoordinator(
            navigationController: navigationController,
            dependencies: self
        )
    }
}

extension PostsDIContraner: SceneDIContainer{
    static var storyBoard: String {
        return "Main"
    }
}
