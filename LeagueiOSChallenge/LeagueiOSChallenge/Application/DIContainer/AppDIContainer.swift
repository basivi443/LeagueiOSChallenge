//
//  AppDIContainer.swift
//  LeagueiOSChallenge
//
//  Created by Basivi Reddy on 08/04/25.
//
import Foundation
final class AppDIContainer{
    
    lazy var appConfiguration = AppConfiguration()
    
    // MARK: - Network
    lazy var apiDataTransferService: DataTransferService = {
        let config = ApiDataNetworkConfig(
            baseURL: URL(string: appConfiguration.apiBaseURL)!
//            queryParameters: [
//                "api_key": appConfiguration.apiKey
//            ]
        )
        let apiDataNetwork = DefaultNetworkService(config: config)
        return DefaultDataTransferService(with: apiDataNetwork)
    }()
    
    // MARK: - DIContainers of scenes
    func makePostsDIContainer() -> PostsDIContraner {
        let dependencies = PostsDIContraner.Dependencies(
            apiDataTransferService: apiDataTransferService)
        return PostsDIContraner(dependencies: dependencies)
    }
}


protocol SceneDIContainer{
    static var storyBoard: String { get }
}
