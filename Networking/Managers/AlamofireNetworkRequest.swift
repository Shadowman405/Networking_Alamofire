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
    
    static func responseString(url: String) {
        request(url).responseString { responseString in
            switch responseString.result {
            case .success(let string):
                print(string)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func response(url: String) {
        request(url).response { response in
            guard let data = response.data,
                  let string = String(data: data, encoding: .utf8) else {return}
            
            print(string)
        }
    }
    
    static func downloadImage(url: String, completion: @escaping (_ image: UIImage)->()) {
        guard let url = URL(string: url) else {return}
        
        request(url).responseData { (responseData) in
        
            switch responseData.result {
            case .success(let data):
                guard let image = UIImage(data: data) else {return}
                completion(image)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func downloadImageWithProgress(url: String, completion: @escaping (_ image: UIImage) -> ()) {
        guard let url = URL(string: url) else {return}
        
        request(url).validate().downloadProgress { progress in
            print("total unit count:\(progress.totalUnitCount)\n")
            print("completed unit count:\(progress.completedUnitCount)\n")
            print("fraction completed:\(progress.fractionCompleted)\n")
            print("localizedDescription:\(progress.localizedDescription)\n")
            print("-----------------------------------------------------")
            
            
        }.response { response in
            guard let data = response.data,let image = UIImage(data: data)  else {return}
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
}
