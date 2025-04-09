//
//  PostDetailsViewModel.swift
//  LeagueiOSChallenge
//
//  Created by Basivi Reddy on 09/04/25.
//

import Foundation

protocol PostDetailsViewModelInput{
    func isValidEmailDomain(_ email: String) -> Bool
}

protocol PostDetailsViewModelOutput{
    var user: UserDTO? {get set}
    func fetchProfile(from urlString: String, completion: @escaping (Data?) -> Void)
   
}

protocol PostDetailsViewModel : PostDetailsViewModelInput,PostDetailsViewModelOutput{
    
}

class DefaultPostDetailsViewModel : PostDetailsViewModel{
    
    
    
    
    private let PostDetailsUseCase: PostDetailsUseCase
    private var moviesLoadTask: Cancellable? { willSet { moviesLoadTask?.cancel() } }
    private let mainQueue: DispatchQueueType
    var user: UserDTO?

    init(PostDetailsUseCase: PostDetailsUseCase, mainQueue: DispatchQueueType = DispatchQueue.main) {
        self.PostDetailsUseCase = PostDetailsUseCase
        self.mainQueue = mainQueue
    }
    
  
    func fetchProfile(from urlString: String, completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL.")
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error downloading image data: \(error)")
                completion(nil)
                return
            }

            guard let data = data else {
                print("No data received.")
                completion(nil)
                return
            }

            completion(data)
        }

        task.resume()
    }
    
    func isValidEmailDomain(_ email: String) -> Bool {
        PostDetailsUseCase.isValidEmailDomain(email)
    }
}

