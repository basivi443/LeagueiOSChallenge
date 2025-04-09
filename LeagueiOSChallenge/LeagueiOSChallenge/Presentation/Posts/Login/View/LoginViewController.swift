//
//  LoginViewController.swift
//  LeagueiOSChallenge
//
//  Created by Basivi Reddy on 08/04/25.
//

import UIKit

class LoginViewController: UIViewController, StoryboardInstantiable{
    
    private var viewModel: LoginViewModel!

    static func create(
        with viewModel: LoginViewModel, storyBoardName: String
    ) -> LoginViewController {
        let view = LoginViewController.instantiateViewController(storyBoardName: storyBoardName)
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showPostListScreen(_ sender : UIButton){
        self.viewModel.showPostListViewScreen(isGuest: false)
    }
    
    @IBAction func showPostListScreenAsGuest(_ sender : UIButton){
        self.viewModel.showPostListViewScreen(isGuest: true)
    }
}
