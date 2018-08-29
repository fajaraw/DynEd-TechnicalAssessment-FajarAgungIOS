//
//  UserModel.swift
//  DynEdTestAssesment
//
//  Created by Fajar on 8/28/18.
//  Copyright © 2018 Fajar. All rights reserved.
//

import SwiftyJSON

class UserModel {

}

class UserModelLite {
    lazy var login = ""
    lazy var name = ""
    lazy var email = ""
    lazy var avatar = ""
    
    init(_ json:JSON) {
        parse(json)
    }
    
    init(){
        
    }
    
    func parse(_ json:JSON){
        login = json["login"].stringValue
        name = json["name"].stringValue
        email = json["email"].stringValue
        avatar = json["avatarUrl"].stringValue
    }
}
