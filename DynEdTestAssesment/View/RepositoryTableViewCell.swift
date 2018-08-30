//
//  RepositoryTableViewCell.swift
//  DynEdTestAssesment
//
//  Created by Fajar on 8/29/18.
//  Copyright © 2018 Fajar. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDesc: UILabel!
    @IBOutlet weak var viewLanguage: UIView!
    @IBOutlet weak var labelLanguage: UILabel!
    @IBOutlet weak var labelFork: UILabel!
    @IBOutlet weak var labelStar: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    
    static var nibName:String {
        return "RepositoryTableViewCell"
    }
    
    static var identifierName:String{
        return "RepoCell"
    }
    
    static var nib:UINib {
        return UINib(nibName: nibName, bundle: nil)
    }
    
    static func dequeueReusableCell(tableView:UITableView,indexPath:IndexPath) -> RepositoryTableViewCell{
        return tableView.dequeueReusableCell(withIdentifier: identifierName, for: indexPath) as! RepositoryTableViewCell
    }
    
    var repo:RepositoryModel? {
        didSet {
            guard let r = repo else {return}
            labelTitle.text = r.name
            labelDesc.text = r.descripition
            labelFork.text = r.forkCount
            labelStar.text = r.starCount
            labelDate.text = r.dateUpdated.format(with: "dd MMMM yyyy, HH:mm")
            labelLanguage.text = r.primaryLanguage.name
            viewLanguage.backgroundColor = r.primaryLanguage.color
        
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    
    
}
