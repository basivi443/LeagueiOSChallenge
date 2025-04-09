//
//  Alertable.swift
//  LeagueiOSChallenge
//
//  Created by Basivi Reddy on 09/04/25.
//

import UIKit

protocol Alertable {}
extension Alertable where Self: UIViewController {
    
    func showAlert(
        title: String = "",
        message: String,
        preferredStyle: UIAlertController.Style = .alert,
        onOK: (() -> Void)? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            onOK?()
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
