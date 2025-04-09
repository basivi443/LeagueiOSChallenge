//
//  PostListViewController.swift
//  LeagueiOSChallenge
//
//  Created by Basivi Reddy on 08/04/25.
//

import UIKit

class PostListViewController: UIViewController, StoryboardInstantiable{
    
    private var viewModel: PostListViewModel!
    @IBOutlet weak var tableView: UITableView!

    static func create(
        with viewModel: PostListViewModel, storyBoardName: String
    ) -> PostListViewController {
        let view = PostListViewController.instantiateViewController(storyBoardName: storyBoardName)
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "PostsTableViewCell", bundle: nil), forCellReuseIdentifier: "PostsTableViewCell")
        viewModel.viewDidLoad()
        self.bind(to: viewModel)
    }
    
    //MARK: - Bind observers
    
    private func bind(to viewModel: PostListViewModel) {
        viewModel.loading.observe(on: self) { [weak self] in
            self?.updateLoading($0)
        }
    }
    
    //MARK: - Loader
    
    private func updateLoading(_ show: Bool){
        tableView.reloadData()
    }
    
}

extension PostListViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostsTableViewCell") as? PostsTableViewCell
        cell?.userNameLbl.text = viewModel.users[indexPath.row].username
        cell?.titleLbl.text = viewModel.users[indexPath.row].name
        cell?.fetchImage(url: viewModel.users[indexPath.row].avatar ?? "")
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    
}
