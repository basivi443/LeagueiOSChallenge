//
//  PostsFlowCoordinatorDependencies.swift
//  LeagueiOSChallenge
//
//  Created by Basivi Reddy on 08/04/25.
//

import UIKit

protocol PostsFlowCoordinatorDependencies{
    func makePostListViewController() -> PostListViewController
}

final class PostsFlowCoordinator{
    
    private weak var navigationController: UINavigationController?
    private let dependencies: PostsFlowCoordinatorDependencies
    private weak var postListVC: PostListViewController?


    init(navigationController: UINavigationController,
         dependencies: PostsFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        // Note: here we keep strong reference with actions, this way this flow do not need to be strong referenced
        let vc = dependencies.makePostListViewController()
        navigationController?.pushViewController(vc, animated: false)
        postListVC = vc
    }
}
