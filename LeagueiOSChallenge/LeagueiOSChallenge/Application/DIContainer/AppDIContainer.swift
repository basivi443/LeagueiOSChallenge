//
//  AppDIContainer.swift
//  LeagueiOSChallenge
//
//  Created by Basivi Reddy on 08/04/25.
//

final class AppDIContainer{
    
    // MARK: - DIContainers of scenes
    func makePostsDIContainer() -> PostsDIContraner {
        let dependencies = PostsDIContraner.Dependencies(
        )
        return PostsDIContraner(dependencies: dependencies)
    }
}


protocol SceneDIContainer{
    static var storyBoard: String { get }
}
