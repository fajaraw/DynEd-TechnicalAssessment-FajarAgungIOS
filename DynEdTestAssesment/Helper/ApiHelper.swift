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
    
    func post(fileName:String, query:String) -> DataRequest? {
        let header = ["Authorization":"Bearer \(APIConstant.oauth)"]
        if let path = Bundle.main.path(forResource: fileName, ofType: "ql"){
            do {
                let queryStr = try String(contentsOfFile: path).replacingOccurrences(of: "#", with: query)
                return request(APIConstant.BaseGraphUrl, method: .post, parameters: ["query":queryStr], encoding: JSONEncoding.default, headers: header)
            }catch let e{
                print("error \(e)")
            }
        }
        return nil
    }
}
