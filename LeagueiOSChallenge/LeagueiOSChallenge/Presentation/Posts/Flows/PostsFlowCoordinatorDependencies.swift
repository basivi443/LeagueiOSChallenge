//
//  PostsFlowCoordinatorDependencies.swift
//  LeagueiOSChallenge
//
//  Created by Basivi Reddy on 08/04/25.
//

import UIKit

protocol PostsFlowCoordinatorDependencies{
    func makePostListViewController() -> PostListViewController
    func makeLoginViewController(actions: LoginViewModelActions) -> LoginViewController

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
       let vc = dependencies.makePostListViewController()
        vc.viewModel.isGuest.value = isGuest
       navigationController?.pushViewController(vc, animated: true)
   }
}
