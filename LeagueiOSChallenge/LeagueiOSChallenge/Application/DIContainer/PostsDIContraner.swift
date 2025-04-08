//
//  PostsDIContraner.swift
//  LeagueiOSChallenge
//
//  Created by Basivi Reddy on 08/04/25.
//
import UIKit

final class PostsDIContraner: PostsFlowCoordinatorDependencies{
    
    struct Dependencies {
       
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Use Cases
    func makePostListUseCase() -> PostListUseCase {
        DefaultPostListUseCase(
            postListRepository: makePostRepository()
        )
    }
    
    // MARK: - Repositories
    func makePostRepository() -> PostListRepository{
        DefaultPostlistRepository()
    }
    func makePostListViewModel() -> PostListViewModel {
        DefaultPostListViewModel(
            postListUseCase: makePostListUseCase()
        )
    }
    
    func makePostListViewController() -> PostListViewController {
        PostListViewController.create(with: makePostListViewModel(), storyBoardName: PostsDIContraner.storyBoard)
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
