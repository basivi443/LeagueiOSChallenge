//
//  PostsTableViewCell.swift
//  LeagueiOSChallenge
//
//  Created by Basivi Reddy on 09/04/25.
//

import UIKit

class PostsTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fetchImage(url: String){
        fetchProfile(from: url) { data in
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.profileImg.image = image
            }
        }
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
}
