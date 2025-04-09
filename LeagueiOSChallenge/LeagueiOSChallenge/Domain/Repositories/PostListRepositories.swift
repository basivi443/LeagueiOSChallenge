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
    
    func fetchUsers1(
        completion: @escaping (Result<[UserDTO], Error>) -> Void
    ) -> Cancellable? {

        let task = RepositoryTask()

        cache.getResponse() { [weak self, backgroundQueue] result in

            guard !task.isCancelled else { return }

            let endpoint = APIEndpoints.getUsers(headers: ["String" : "String"])
            task.networkTask = self?.dataTransferService.request(
                with: endpoint,
                on: backgroundQueue
            ) { result in
                switch result {
                case .success(let responseDTO):
                    completion(.success(responseDTO))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        return task
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
class RepositoryTask: Cancellable {
    var networkTask: NetworkCancellable?
    var isCancelled: Bool = false
    
    func cancel() {
        networkTask?.cancel()
        isCancelled = true
    }
}

struct APIEndpoints {
    
    static func getUsers(headers:[String:String]? = nil) -> Endpoint<[UserDTO]>{
        return Endpoint(path: "/users",
                        method: .get,
                        headerParameters: headers ?? [:]
        )
    }
    
    static func getProfile(path: String) -> Endpoint<Data?>{
        return Endpoint(path: path,
                        method: .get,
        )
    }
    //https://i.pravatar.cc/150?u=
}

struct MMPResponse<T: Decodable>: Decodable {
    let status:Int
    let success:Bool
    let message:String
    let data: T?
}

import Foundation
extension Error{
    static func error(withMessage message: String) -> Error{
        NSError.init(domain: "MMP Error", code: -1000, userInfo: ["message": message])
    }
    
    var message: String? {
        return (self as NSError?)?.userInfo["message"] as? String
    }
    static func unknownError() -> Error {
        NSError.init(domain: "MMP Error", code: -1000, userInfo: ["message": "Unknown Error Occured"])
    }
}

enum MMPError: Error{
    
}
