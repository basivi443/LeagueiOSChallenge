//
//  PostDetailsViewController.swift
//  LeagueiOSChallenge
//
//  Created by Basivi Reddy on 09/04/25.
//

import UIKit

class PostDetailsViewController: UIViewController, StoryboardInstantiable, Alertable{
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userEmailLbl: UILabel!
    @IBOutlet weak var warningIcon: UIImageView!
     var viewModel: PostDetailsViewModel!
    
    static func create(
        with viewModel: PostDetailsViewModel, storyBoardName: String
    ) -> PostDetailsViewController {
        let view = PostDetailsViewController.instantiateViewController(storyBoardName: storyBoardName)
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupUIData()
    }
    
    func setupUIData(){
        self.userNameLbl.text = self.viewModel.user?.name
        self.userEmailLbl.text = self.viewModel.user?.email
        let isValid = viewModel.isValidEmailDomain(self.viewModel.user?.email ?? "")
        self.warningIcon.isHidden = isValid ? true : false
        viewModel.fetchProfile(from: self.viewModel.user?.avatar ?? "") { data in
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.profileImg.image = image
            }
        }
    }
    func setupNavBar(){
        let backBarButton = UIBarButtonItem.init(image: UIImage.init(named: "back_arrow"), style: .plain, target: self, action: #selector(backClicked(_:)))
        self.setupNavigationItem(with: "", mainTitle: "Post Details", backItem: backBarButton, rightitems: [])
    }
    
    @objc func backClicked(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    

}

