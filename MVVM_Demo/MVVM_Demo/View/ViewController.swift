//
//  ViewController.swift
//  MVVM_Demo
//
//  Created by Apple on 15/05/25.
//

import UIKit

class ViewController: UIViewController {
    
    let tableView = UITableView()
    let viewModel = UserListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        bindViewMOdel()
        viewModel.fetchUser()
    }
    
    
    func setUpTableView(){
        tableView.frame = view.bounds
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.backgroundColor = .systemCyan
    }
    
    func bindViewMOdel(){
        viewModel.onUserUpdate = {[weak self] in
            DispatchQueue.main.async{
                self?.tableView.reloadData()
            }
        }
    }
   

}
extension ViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = viewModel.users[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        cell.backgroundColor = .lightText
        return cell
    }
    
    
}

