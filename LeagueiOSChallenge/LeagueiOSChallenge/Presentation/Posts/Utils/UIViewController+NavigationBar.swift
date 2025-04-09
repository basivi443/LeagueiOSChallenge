//
//  UIViewController+NavigationBar.swift
//  Notes
//
//  Created by Basivi Reddy - 2505 on 12/09/22.
//

import Foundation
import UIKit
extension UIViewController{
    func setupNavigationItem(with backtitle: String?, mainTitle: String, backItem: UIBarButtonItem? = nil, rightitems: [UIBarButtonItem]){
        
        guard let navVC = self.navigationController else {return}
        var leftItems:[UIBarButtonItem] = []
        if navVC.viewControllers.count > 1 {
            if let backItem = backItem{
                leftItems.append(backItem)
            }else{
                let backitem = BackBarButtonItem.init(image: UIImage.init(named: "back_arrow"), style: .plain) { item in
                    navVC.popViewController(animated: true)
                }
                leftItems.append(backitem)
            }
        }else{
            if let backItem = backItem{
                leftItems.append(backItem)
            }
        }
        self.navigationItem.title = mainTitle
        if backtitle != nil{
            let titleItem = UIBarButtonItem.init(title: backtitle, style: .plain, target: self, action: #selector(BackTitle))
            titleItem.setTitleTextAttributes([.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 18)], for: .normal)
            leftItems.append(titleItem)
        }
       
        self.navigationItem.rightBarButtonItems = rightitems
        self.navigationItem.leftBarButtonItems = leftItems
        
    }
    
    @objc func BackTitle(){
        self.navigationController?.popViewController(animated:true)
    }
    
}
