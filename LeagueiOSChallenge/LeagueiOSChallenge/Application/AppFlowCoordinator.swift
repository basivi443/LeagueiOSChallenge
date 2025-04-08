//
//  AppFlowCoordinator.swift
//  LeagueiOSChallenge
//
//  Created by Basivi Reddy on 08/04/25.
//

import UIKit

final class AppFlowCoordinator {

    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(
        navigationController: UINavigationController,
        appDIContainer: AppDIContainer
    ) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }

    func start() {
        // In App Flow we can check if user needs to login, if yes we would run login flow
        let postsDIContainer = appDIContainer.makePostsDIContainer()
        let flow = postsDIContainer.makePostsFlowCoordinator(navigationController: navigationController)
        flow.start()
    }
}
