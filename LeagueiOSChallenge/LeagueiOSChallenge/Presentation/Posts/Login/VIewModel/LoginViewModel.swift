//
//  LoginViewModel.swift
//  LeagueiOSChallenge
//
//  Created by Basivi Reddy on 08/04/25.
//

import Foundation
struct LoginViewModelActions{
    let showPostListViewScreen : () -> Void
}

protocol LoginViewModelInput{
    func showPostListViewScreen()
}

protocol LoginViewModelOutput{

}

protocol LoginViewModel : LoginViewModelInput,LoginViewModelOutput{
    
}

class DefaultLoginViewModel : LoginViewModel{
    
    private let actions: LoginViewModelActions?
    
    init(actions: LoginViewModelActions? = nil) {
        self.actions = actions
    }
     
    func showPostListViewScreen() {
        actions?.showPostListViewScreen()
    }
}

