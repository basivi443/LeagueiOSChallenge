//
//  PostsFlowCoordinatorDependencies.swift
//  LeagueiOSChallenge
//
//  Created by Basivi Reddy on 08/04/25.
//

import UIKit

protocol PostsFlowCoordinatorDependencies{
    func makePostListViewController(actions: PostListViewModelActions) -> PostListViewController
    func makeLoginViewController(actions: LoginViewModelActions) -> LoginViewController
    func makePostDetailsViewController() -> PostDetailsViewController
}

final class PostsFlowCoordinator{
    
    private weak var navigationController: UINavigationController?
    private let dependencies: PostsFlowCoordinatorDependencies
    private weak var postListVC: PostListViewController?
    private weak var loginVC: LoginViewController?


    init(navigationController: UINavigationController,
         dependencies: PostsFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        // Note: here we keep strong reference with actions, this way this flow do not need to be strong referenced
        let actions = LoginViewModelActions(showPostListViewScreen: showPostListViewScreen)
        let vc = dependencies.makeLoginViewController(actions: actions)
        navigationController?.pushViewController(vc, animated: false)
        loginVC = vc
    }
    
    func showPostListViewScreen(isGuest: Bool){
        let actions = PostListViewModelActions(showPostDetailsViewScreen: showPostDetailsViewScreen)
        let vc = dependencies.makePostListViewController(actions: actions)
        vc.viewModel.isGuest.value = isGuest
       navigationController?.pushViewController(vc, animated: true)
   }
    
    func showPostDetailsViewScreen(user: UserDTO){
       let vc = dependencies.makePostDetailsViewController()
        vc.viewModel.user = user
       navigationController?.pushViewController(vc, animated: true)
   }
    
    
}
