//
//  PostDetailsUseCase.swift
//  LeagueiOSChallenge
//
//  Created by Basivi Reddy on 09/04/25.
//

import Foundation

protocol PostDetailsUseCase{
    func isValidEmailDomain(_ email: String) -> Bool
}

class DefaultPostDetailsUseCase: PostDetailsUseCase{
    private var postDetailsRepository: PostDetailsRepository
    
    init(postDetailsRepository: PostDetailsRepository) {
        self.postDetailsRepository = postDetailsRepository
    }
    
    func isValidEmailDomain(_ email: String) -> Bool {
        let pattern = #"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.(com|net|biz)$"#
        let regex = try! NSRegularExpression(pattern: pattern, options: [.caseInsensitive])
        let range = NSRange(location: 0, length: email.utf16.count)
        return regex.firstMatch(in: email, options: [], range: range) != nil
    }
}
