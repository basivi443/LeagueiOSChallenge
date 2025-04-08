//
//  PostListViewController.swift
//  LeagueiOSChallenge
//
//  Created by Basivi Reddy on 08/04/25.
//

import UIKit

class PostListViewController: UIViewController, StoryboardInstantiable{
    
    private var viewModel: PostListViewModel!

    static func create(
        with viewModel: PostListViewModel, storyBoardName: String
    ) -> PostListViewController {
        let view = PostListViewController.instantiateViewController(storyBoardName: storyBoardName)
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
