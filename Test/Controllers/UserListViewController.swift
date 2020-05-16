//
//  UserListViewController.swift
//  Test
//
//  Created by Ashu Baweja on 15/05/20.
//  Copyright © 2019 Ashu Baweja. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var userListTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Constants
    var userList = [User]()
    
    
    // MARK: Initialization Methods
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.navigationItem.title = kUserListTitle
        let userCellNib = UINib(nibName: kUserCell, bundle: nil)
        userListTableView.register(userCellNib, forCellReuseIdentifier: kUserCell)
        
        fetchUsers()
    }
    
    
    // MARK: Private Methods
    /// This method will fetch user list
    private func fetchUsers(){
        weak var weakSelf = self
        activityIndicator.startAnimating()
        UserListHandler.fetchUserList{ (users, error) in
            DispatchQueue.main.async {
                weakSelf?.activityIndicator.stopAnimating()
                if users?.count ?? 0 > 0 {
                    weakSelf?.userList = users ?? []
                    weakSelf?.userListTableView.reloadData()
                    weakSelf?.userListTableView.isHidden = false
                }
            }
        }
    }
}


//// MARK: UITableView Delegates & Datasource
extension UserListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kUserCell, for: indexPath)
        cell.selectionStyle = .none
        if let userCell = cell as? UserCell {
            userCell.configureUserCell(user: userList[indexPath.row])
        }
        return cell
    }
}



