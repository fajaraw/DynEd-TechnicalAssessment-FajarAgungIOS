//
//  MainViewModel.swift
//  DynEdTestAssesment
//
//  Created by Fajar on 8/28/18.
//  Copyright © 2018 Fajar. All rights reserved.
//

import Alamofire
import SwiftyJSON
import RxCocoa
import RxSwift

class MainViewModel {
    
    var queryString = BehaviorRelay<String?>(value:nil)
    var userList = BehaviorRelay<[UserModelLite]>(value:[])
    let disposeBag = DisposeBag()
    
    init() {
        queryString.throttle(1, scheduler: MainScheduler.instance).bind { (str) in
            if str != nil {
                self.searchUser()
            }
        }.disposed(by: disposeBag)
    }

    func searchUser(){
        if let req = ApiHelper.instance.post(fileName: "searchUser", query: queryString.value ?? "") {
            req.responseJSON(completionHandler: { (response) in
                if response.result.isSuccess {
                    let json = JSON(response.result.value ?? "")
                    let items = json["data"]["search"]["nodes"].arrayValue
                    var temp:[UserModelLite] = []
                    items.forEach({ (json) in
                        temp.append(UserModelLite(json))
                    })
                    self.userList.accept(temp)
                }
            })
        }
    }
}
