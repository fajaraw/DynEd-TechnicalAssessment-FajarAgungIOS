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
    var repoList = BehaviorRelay<[RepositoryModel]>(value:[])
    var error = BehaviorRelay<Error?>(value: nil)
    var selectedUser = UserModelLite()
    let disposeBag = DisposeBag()
    var isLoadMore = false
    private var tempLoadMore = false
    var lastCursor = ""
    
    init() {
        queryString.throttle(1, scheduler: MainScheduler.instance).bind { (str) in
            if str != nil {
                self.searchUser()
            }
        }.disposed(by: disposeBag)
    }
    
    func changeLoadMore(){
        isLoadMore = tempLoadMore
    }

    func searchUser(){
        if let query = ApiHelper.getFile(fileName: "searchUser"){
        let q = query.replacingOccurrences(of: "#", with: queryString.value ?? "")
        ApiHelper.instance.post(query: q)
            .responseJSON(completionHandler: { (response) in
                print(response.result.value)
                if response.result.isSuccess {
                    let json = JSON(response.result.value ?? "")
                    if let badMessage = json["message"].string {
                        self.error.accept(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey:badMessage]))
                    }
                    let items = json["data"]["search"]["nodes"].arrayValue
                    var temp:[UserModelLite] = []
                    items.forEach({ (json) in
                        temp.append(UserModelLite(json))
                    })
                    self.userList.accept(temp)
                }else{
                    self.error.accept(response.error)
                }
            })
        }
    }
    
    func getRepository(){
        self.repoList.accept([])
        getListRepo(cursor: "null")
    }
    
    private func getListRepo(cursor:String,defaultList:[RepositoryModel] = []){
        if let query = ApiHelper.getFile(fileName: "repo"){
            let q = query.replacingOccurrences(of: "#1", with: selectedUser.login).replacingOccurrences(of: "#2", with: cursor)
            ApiHelper.instance.post(query: q)
                .responseJSON(completionHandler: { (response) in
                    if response.result.isSuccess {
                        let json = JSON(response.result.value ?? "")
                        let items = json["data"]["user"]["repositories"]["edges"].arrayValue
                        var temp:[RepositoryModel] = defaultList
                        print("count \(items.count)")
                        items.forEach({ (json) in
                            temp.append(RepositoryModel(json["node"]))
                        })
                        if items.count == 10 {
                            self.tempLoadMore = true
                            self.lastCursor = items.last!["cursor"].stringValue
                        }
                        self.repoList.accept(temp)
                    }else{
                        self.error.accept(response.error)
                    }
                })
        }
    }
    
    func loadMore(){
        isLoadMore = false
        tempLoadMore = false
        getListRepo(cursor: "\"\(lastCursor)\"", defaultList: repoList.value)
    }
}
