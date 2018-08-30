//
//  DetailRepositoryViewModel.swift
//  DynEdTestAssesment
//
//  Created by Fajar on 8/29/18.
//  Copyright © 2018 Fajar. All rights reserved.
//

import RxSwift
import RxCocoa
import Alamofire
import SwiftyJSON

class DetailRepositoryViewModel {
    var login = ""
    var repoName = ""
    var repository = BehaviorRelay<RepositoryModel>(value:RepositoryModel())
    var error = BehaviorRelay<Error?>(value: nil)
    let disposeBag = DisposeBag()
    fileprivate let queryBase = "owner:\"#1\",name:\"#2\""
    
    func getRepository(){
        if let query = ApiHelper.getFile(fileName: "repoDetail") {
            let q = query.replacingOccurrences(of: "#1", with: login).replacingOccurrences(of: "#2", with: repoName)
            ApiHelper.instance.post(query: q)
            .responseJSON(completionHandler: { (response) in
                if response.result.isSuccess {
                    let json = JSON(response.result.value ?? "")
                    let item = json["data"]["repository"]
                    let repo = RepositoryModel(detail:item)
                    self.repository.accept(repo)
                }else{
                    self.error.accept(response.error)
                }
            })
        }
    }

}
