//
//  AlamofireNetworkRequest.swift
//  Networking
//
//  Created by Maxim Mitin on 27.01.22.
//  Copyright © 2022 Alexey Efimov. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireNetworkRequest {
    
    static func sendRequest(url:String, completion: @escaping (_ courses: [Course]) -> ()){
        guard let url = URL(string: url) else {return}
        request(url, method: .get).validate().responseJSON { (response) in
            switch response.result {
                case .success(let value):
                    var courses = [Course]()
                    courses = Course.getArray(from: value)!
                    completion(courses)
                    
            case .failure(let error):
                    print(error)
            }
        }
    }
    
    static func responseData(url: String){
        request(url).responseData { responseData in
            switch responseData.result {
            case .success(let data):
                guard let string = String(data: data, encoding: .utf8) else {return}
                print(string)
            case .failure(let error):
                print(error)
            }
        }
    }
}
