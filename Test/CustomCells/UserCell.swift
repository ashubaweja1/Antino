//
//  UserCell
//  Test
//
//  Created by Ashu Baweja on 15/05/20.
//  Copyright © 2019 Ashu Baweja. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    @IBOutlet weak var userImage: UIImageView?
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userAge: UILabel!
    @IBOutlet weak var userLocation: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /// This method will configure the user cell
    /// - Parameter user : User model object
    func configureUserCell(user: User){
        userName.text = user.name
        userAge.text = user.age
        userLocation.text = user.location

        userImage?.image = UIImage(named: "placeHolder")
        let fileURL = UserListHandler.getFileUrl(imageName: user.name ?? "")
        
        // Check if image exists in directory else download and save to directory
        if UserListHandler.checkIfImageExists(fileURL: fileURL) {
            DispatchQueue.main.async {
                let imageUrl = UserListHandler.getFileUrl(imageName: user.name ?? "")
                let image = UserListHandler.getImageFromDirectory(path: imageUrl.path)
                self.userImage?.image = image
            }
        }
        else  if let imageUrl = user.url, let url = URL(string: imageUrl) {
            weak var weakSelf = self
            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    let data = try Data(contentsOf: url)
                    DispatchQueue.main.async {
                        weakSelf?.userImage?.image = UIImage(data: data)
                        UserListHandler.saveImageToDirectory(data: data, imageName: user.name ?? "")
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
