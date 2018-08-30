//
//  RepositoryModel.swift
//  DynEdTestAssesment
//
//  Created by Fajar on 8/29/18.
//  Copyright © 2018 Fajar. All rights reserved.
//

import SwiftyJSON
import DateToolsSwift

class RepositoryModel {
    var name = ""
    var id = ""
    var descripition = ""
    var forkCount = ""
    var starCount = ""
    var datePushed = Date()
    var dateUpdated = Date()
    var ownerName = ""
    var primaryLanguage = LanguageModel()
    
    lazy var releaseCount = ""
    lazy var wathcerCount = ""
    lazy var pullCount = ""
    lazy var issueCount = ""
    lazy var branchCount = ""
    lazy var commitCount = ""
    lazy var licenseInfo = ""
    lazy var readmeText = ""
    
    init() {
        
    }
    
    init(_ json:JSON) {
        parse(json)
    }
    
    init(detail:JSON) {
        detailParse(detail)
    }
    
    func parse(_ json:JSON){
        name = json["name"].stringValue
        id = json["id"].stringValue
        descripition = json["description"].stringValue
        forkCount = json["forkCount"].stringValue
        starCount = json["stargazers"]["totalCount"].stringValue
        let push = json["pushedAt"].stringValue
        let update = json["updatedAt"].stringValue
        datePushed = Date(dateString: push, format: "yyyy-MM-dd'T'HH:mm:ss'Z'")
        dateUpdated = Date(dateString: update, format: "yyyy-MM-dd'T'HH:mm:ss'Z'")
        ownerName = json["owner"]["login"].stringValue
        primaryLanguage = LanguageModel(json["primaryLanguage"])
        
    }
    
    func detailParse(_ json:JSON){
        parse(json)
        licenseInfo = json["licenseInfo"]["name"].stringValue
        releaseCount = json["releases"]["totalCount"].stringValue
        wathcerCount = json["watchers"]["totalCount"].stringValue
        pullCount = json["pullRequests"]["totalCount"].stringValue
        issueCount = json["issues"]["totalCount"].stringValue
        branchCount = json["refs"]["totalCount"].stringValue
        commitCount = json["object"]["history"]["totalCount"].stringValue
        readmeText = json["readme"]["text"].stringValue
    }
}

class LanguageModel {
    var name = ""
    var color = UIColor.black
    
    init() {
        
    }
    
    init(_ json:JSON) {
        parse(json)
    }
    
    func parse(_ json:JSON){
        name = json["name"].string ?? "Text"
        color = UIColor(hex: json["color"].stringValue)
    }
}
