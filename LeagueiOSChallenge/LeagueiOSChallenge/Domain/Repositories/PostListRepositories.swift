//
//  PostListRepositories.swift
//  LeagueiOSChallenge
//
//  Created by Basivi Reddy on 08/04/25.
//
import Foundation

protocol PostListRepository{
    @discardableResult
    func fetchUsers(
        completion: @escaping (Result<[UserDTO], Error>) -> Void
    ) -> Cancellable?
    func fetchApiKey() -> String
    
}

final class DefaultPostlistRepository: PostListRepository{
    
    private let dataTransferService: DataTransferService
    private let backgroundQueue: DataTransferDispatchQueue
    private let cache: UserResponse

    init(
        dataTransferService: DataTransferService,
        cache: UserResponse,
        backgroundQueue: DataTransferDispatchQueue = DispatchQueue.global(qos: .userInitiated)
    ) {
        self.dataTransferService = dataTransferService
        self.backgroundQueue = backgroundQueue
        self.cache = cache
    }
    
   
    
    func fetchUsers(completion: @escaping (Result<[UserDTO], Error>) -> Void) -> Cancellable? {
        let key = fetchApiKey()
        print(key)
        let task = RepositoryTask()
        let endPoint = APIEndpoints.getUsers(headers: ["x-access-token": "BD04309C714D0BCEFAFD49B46A3338EC" ])
        task.networkTask = self.dataTransferService.request(with: endPoint, completion: { result in
            switch result {
            case .success(let responseDTO):
                    completion(.success(responseDTO))
            case .failure(let error):
                completion(.failure(error))
            }
            
        })
        return task
    }
    
    func fetchApiKey() -> String {
        let task = RepositoryTask()
        let endPoint = APIEndpoints.getApiKey()
        task.networkTask = self.dataTransferService.request(with: endPoint, completion: { result in
            print(result)
        })
        return ""
    }
    
}

protocol UserResponse {
    func getResponse(
        completion: @escaping (Result<[UserDTO]?, Error>) -> Void
    )
}

class ResponseStorage: UserResponse{
    func getResponse(completion: @escaping (Result<[UserDTO]?, any Error>) -> Void) {
        print("")
    }
}
