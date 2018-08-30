//
//  ApiHelper.swift
//  DynEdTestAssesment
//
//  Created by Fajar on 8/28/18.
//  Copyright © 2018 Fajar. All rights reserved.
//

import Alamofire

class ApiHelper: NSObject {
    static let instance = ApiHelper()
    
    func post(query:String) -> DataRequest{
        let header = ["Authorization":"Bearer \(APIConstant.token)"]
        return request(APIConstant.BaseGraphUrl, method: .post, parameters: ["query":query], encoding: JSONEncoding.default, headers: header)
    }
    
    static func getFile(fileName:String) ->String? {
        if let path = Bundle.main.path(forResource: fileName, ofType: "ql"){
            do {
                return try String(contentsOfFile: path)
            }catch let e{
                print("error \(e)")
                return nil
            }
        }
        return nil
    }
}
