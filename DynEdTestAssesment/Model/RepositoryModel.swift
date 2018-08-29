//
//  RepositoryModel.swift
//  DynEdTestAssesment
//
//  Created by Fajar on 8/29/18.
//  Copyright © 2018 Fajar. All rights reserved.
//

import SwiftyJSON
import date

class RepositoryModel {
    var name = ""
    var id = ""
    var datePushed = Date()
    var dateUpdated = Date()
    var ownerName = ""
    var languangeUsed = [LanguageModel]()
    
    init() {
        
    }
    
    init(_ json:JSON) {
        parse(json)
    }
    
    func parse(_ json:JSON){
        name = json["name"].stringValue
        id = json["id"].stringValue
        let push = json["pushedAt"].stringValue
        let update = json["updatedAt"].stringValue
//        datePushed = Date(
        ownerName = json["owner"]["login"].stringValue
        languangeUsed.removeAll()
        json[""].arrayValue.forEach { (json) in
            languangeUsed.append(LanguageModel(json))
        }
        
    }
}

class LanguageModel {
    var name = ""
    var color = UIColor.black
    
    init(_ json:JSON) {
        parse(json)
    }
    
    func parse(_ json:JSON){
        name = json[""].stringValue
    }
}
