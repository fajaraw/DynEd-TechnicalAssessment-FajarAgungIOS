//
//  ViewController.swift
//  DynEdTestAssesment
//
//  Created by Fajar on 8/28/18.
//  Copyright © 2018 Fajar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let vm = MainViewModel()
    
    @IBOutlet weak var tableViewUser: UITableView!
    @IBOutlet weak var tableViewRepo: UITableView!
    @IBOutlet weak var fieldSearch: UITextField!
    @IBOutlet weak var holderBlack: UIView!
    @IBOutlet weak var imageCover: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelLogin: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelFollower: UILabel!
    @IBOutlet weak var labelFollowing: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm.userList.bind { (_) in
            print("user \(self.vm.userList.value.count)")
            self.tableViewUser.reloadData()
            
        }.disposed(by: vm.disposeBag)
        vm.repoList.bind { (_) in
            self.tableViewRepo.reloadData()
            self.vm.changeLoadMore()
        }.disposed(by: vm.disposeBag)
        vm.error.bind { (error) in
            guard let e = error else {return}
            let alert = UIAlertController(title: "Error", message: e.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { (_) in
                alert.dismiss(animated: true, completion: nil)
                
            }))
            self.view.endEditing(true)
            self.present(alert, animated: true, completion: nil)
        }.disposed(by: vm.disposeBag)
        fieldSearch.rx.text.orEmpty.bind(to: vm.queryString).disposed(by: vm.disposeBag)
        tableViewRepo.register(RepositoryTableViewCell.nib, forCellReuseIdentifier: RepositoryTableViewCell.identifierName)
        tableViewRepo.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func dismisView(_ sender: Any) {
//        self.tableViewUser.isHidden = true
//        self.holderBlack.isHidden = true
        self.view.endEditing(true)
    }
    
}

extension ViewController :UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == tableViewUser ? vm.userList.value.count : vm.repoList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableViewUser {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserListCell
            let item = vm.userList.value[indexPath.row]
            cell.imageCover.setImageURL(url: item.avatar)
            cell.labelEmail.text = item.email
            cell.labelTitle.text = "\(item.name)/\(item.login)"
            return cell
        }else{
            let cell = RepositoryTableViewCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
            cell.repo = vm.repoList.value[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableViewUser {
            let user = vm.userList.value[indexPath.row]
            vm.selectedUser = user
            fieldSearch.text = user.login
            self.view.endEditing(true)
            labelName.text = user.name
            labelLogin.text = user.login
            labelEmail.text = user.email
            imageCover.setImageURL(url: user.avatar)
            labelFollower.text = user.followersCount
            labelFollowing.text = user.followingCount
            self.vm.getRepository()
        }else{
            let item = vm.repoList.value[indexPath.row]
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "detailVC") as! DetailRepositoryViewController
            vc.vm.login = labelLogin.text ?? ""
            vc.vm.repoName = item.name
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > scrollView.contentSize.height - 100 - scrollView.bounds.size.height {
            if vm.isLoadMore {
                vm.loadMore()
            }
        }
    }
}

extension ViewController:UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.tableViewUser.isHidden = true
        self.holderBlack.isHidden = true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.tableViewUser.isHidden = false
        self.holderBlack.isHidden = false
    }
}

class UserListCell:UITableViewCell{
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imageCover: UIImageView!
    
}

