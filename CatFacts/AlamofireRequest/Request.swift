//
//  Request.swift
//  CatFacts
//
//  Created by Serhii PERKHUN on 1/8/19.
//  Copyright © 2019 Serhii PERKHUN. All rights reserved.
//

import Foundation
import Alamofire

struct Request {
    let url = "https://cat-fact.herokuapp.com/facts"
    
    func getFacts(completion: @escaping ((Result<CatFacts>) -> Void)) {
        request(url).validate().responseData { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    var result: CatFacts?
                    
                    do {
                        result = try JSONDecoder().decode(CatFacts.self, from: value)
                    }
                    catch let error {
                        completion(.failure(error))
                    }
                    completion(.success(result!))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
