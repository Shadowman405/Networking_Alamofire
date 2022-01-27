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
    
    static func sendRequest(url:String){
        guard let url = URL(string: url) else {return}
        request(url, method: .get).responseJSON { response in
            print(response)
        }
    }
}
