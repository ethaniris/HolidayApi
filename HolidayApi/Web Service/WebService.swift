//
//  WebService.swift
//  HolidayApi
//
//  Created by Ethan on 2020/1/29.
//  Copyright © 2020 playplay. All rights reserved.
//

import Foundation


class WebService {
    
    typealias completionHandler = ((HolidayListViewModel?) ->())
        
    func getHoliday(country:String,completion:@escaping completionHandler) {
        
        let urlString = "https://calendarific.com/api/v2/holidays?api_key=569b24e0539c78c893388cfaaeec1dec3a9ceca9&country=\(country)&year=2019"
        
        //be able to read chinese in url
//        let urlEncodingString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        let url = URL(string: urlString)

        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
             completion(nil)
            }
            
            do{
                
                if let data = data {
                
                let record = try JSONDecoder().decode(HolidayListViewModel.self, from: data)
                    print(record)
                completion(record)
                    
                }
                
            } catch {
                
                print(error.localizedDescription)
            }
            
            
        }.resume()
        
        
    }
    
    
    
}
