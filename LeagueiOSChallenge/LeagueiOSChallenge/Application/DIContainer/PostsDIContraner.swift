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
    
    // MARK: - Use Cases
    func makePostListUseCase() -> PostListUseCase {
        DefaultPostListUseCase(
            postListRepository: makePostRepository()
        )
    }
    
    // MARK: - Repositories
    func makePostRepository() -> PostListRepository{
        DefaultPostlistRepository(dataTransferService: dependencies.apiDataTransferService, cache: userResponseCache)
    }
    func makePostListViewModel() -> PostListViewModel {
        DefaultPostListViewModel(
            postListUseCase: makePostListUseCase()
        )
    }
    
    func makeLoginViewModel(action: LoginViewModelActions)-> LoginViewModel{
        DefaultLoginViewModel(actions: action)
    }
    
    func makePostListViewController() -> PostListViewController {
        PostListViewController.create(with: makePostListViewModel(), storyBoardName: PostsDIContraner.storyBoard)
    }
    
    func makeLoginViewController(actions action: LoginViewModelActions) -> LoginViewController {
        LoginViewController.create(with: makeLoginViewModel(action: action), storyBoardName: PostsDIContraner.storyBoard)
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
