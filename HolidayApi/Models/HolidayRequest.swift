//
//  HolidayRequest.swift
//  HolidayApi
//
//  Created by Ethan on 2020/1/30.
//  Copyright © 2020 playplay. All rights reserved.
//

import Foundation

enum RequestError:Error {
    case dataNotAvailable
    case incorrectURL
}

struct Resource<T:Decodable>{
    let resourceURL:URL
    let API_KEY = "569b24e0539c78c893388cfaaeec1dec3a9ceca9"
    
    init(countryCode:String) {
        
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        let currentYear = format.string(from: date)
        
        let urlString = "https://calendarific.com/api/v2/holidays?api_key=\(API_KEY)&country=\(countryCode)&year=\(currentYear)"
        
        guard let url = URL(string: urlString) else {fatalError()}
        
        self.resourceURL = url
    }
}


struct GenericWebService{
    
    func load<T>(resource:Resource<T>,completion:@escaping(Result<T,RequestError>)->()) {
        
        let dataTask = URLSession.shared.dataTask(with: resource.resourceURL) { (data, _, _)
            in
            guard let data = data else {
                completion(.failure(.dataNotAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()

                let jsonData = try decoder.decode(T.self, from: data)
            
                completion(.success(jsonData))
                
            } catch {
                completion(.failure(.dataNotAvailable))
            }
        }
        dataTask.resume()
    }
}
