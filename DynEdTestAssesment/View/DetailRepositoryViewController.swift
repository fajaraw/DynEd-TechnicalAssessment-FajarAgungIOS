//
//  DetailRepositoryViewController.swift
//  DynEdTestAssesment
//
//  Created by Fajar on 8/29/18.
//  Copyright © 2018 Fajar. All rights reserved.
//

import UIKit
import WebKit
import MarkdownView

class DetailRepositoryViewController: UIViewController {

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelLogin: UILabel!
    @IBOutlet weak var labelCommit: UILabel!
    @IBOutlet weak var labelBranch: UILabel!
    @IBOutlet weak var labelRelease: UILabel!
    @IBOutlet weak var labelStar: UILabel!
    @IBOutlet weak var labelFork: UILabel!
    @IBOutlet weak var labelWatch: UILabel!
    @IBOutlet weak var labelLicense: UILabel!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var markdown: MarkdownView!
    
    
    let vm = DetailRepositoryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm.repository.bind { (repo) in
            self.labelName.text = repo.name
            self.labelLogin.text = repo.ownerName
            self.labelCommit.text = repo.commitCount
            self.labelBranch.text = repo.branchCount
            self.labelRelease.text = repo.releaseCount
            self.labelStar.text = repo.starCount
            self.labelFork.text = repo.forkCount
            self.labelWatch.text = repo.wathcerCount
            self.labelLicense.text = repo.licenseInfo
//            self.webView.loadHTMLString(repo.readmeText, baseURL: nil)
            self.markdown.load(markdown: repo.readmeText, enableImage: true)
        }.disposed(by: vm.disposeBag)
        vm.getRepository()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonOnClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
