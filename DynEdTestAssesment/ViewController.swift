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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm.userList.bind { (list) in
            self.tableViewUser.reloadData()
        }.disposed(by: vm.disposeBag)
        fieldSearch.rx.text.orEmpty.bind(to: vm.queryString).disposed(by: vm.disposeBag)
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
        return tableView == tableViewUser ? vm.userList.value.count : 0
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
            return UITableViewCell()
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

