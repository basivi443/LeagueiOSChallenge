//
//  PostListViewController.swift
//  LeagueiOSChallenge
//
//  Created by Basivi Reddy on 08/04/25.
//

import UIKit

class PostListViewController: UIViewController, StoryboardInstantiable, Alertable{
    
     var viewModel: PostListViewModel!
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
        setupNavBar()
    }
    
    func setupNavBar(){
        let backBarButton = UIBarButtonItem.init(image: UIImage.init(named: "back_arrow"), style: .plain, target: self, action: #selector(backClicked(_:)))
        let logutButton = UIBarButtonItem.init(title: viewModel.logoutTitle.value, style: .plain, target: self, action:  #selector(backClicked(_:)))
        self.setupNavigationItem(with: "League", mainTitle: "", backItem: backBarButton, rightitems: [logutButton])
    }
    
    @objc func backClicked(_ sender: UIButton){
        if viewModel.isGuest.value{
            showAlert(title: "Alert", message: "Thank you for trialing this app") {
                self.navigationController?.popViewController(animated: true)
            }
            return
        }
        self.navigationController?.popViewController(animated: true)
        
    }
    //MARK: - Bind observers
    
    private func bind(to viewModel: PostListViewModel) {
        viewModel.loading.observe(on: self) { [weak self] in
            self?.updateLoading($0)
        }
        viewModel.isGuest.observe(on: self) { [weak self] in
            self?.updateTitle($0)
        }
    }
    
    //MARK: - Loader
    
    private func updateLoading(_ show: Bool){
        tableView.reloadData()
    }
    private func updateTitle(_ show: Bool){
        viewModel.logoutTitle.value = show ? "Exit" : "Logout"
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
        cell?.selectionStyle = .none
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.showPostDetailsViewScreen(user: viewModel.users[indexPath.row])
    }
}
