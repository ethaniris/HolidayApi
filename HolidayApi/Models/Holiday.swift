//
//  Holiday.swift
//  HolidayApi
//
//  Created by Ethan on 2020/1/29.
//  Copyright © 2020 playplay. All rights reserved.
//

import Foundation


struct Holiday:Decodable{
    let name:Dynamic<String>
    let description:Dynamic<String>
    let date:Dynamic<DateInfo>
    
    private enum CodingKeys:CodingKey{
        case name, description, date
    }
    
    init(from decoder:Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = Dynamic(value: try container.decode(String.self, forKey: .name))
        description = Dynamic(value: try container.decode(String.self, forKey: .description))
        date = Dynamic(value: try container.decode(DateInfo.self, forKey: .date))
    }
    
    
}
struct DateInfo:Decodable{
    let iso:Dynamic<String>
    
    private enum CodingKeys:CodingKey{
        case iso
    }
    
    init(from decoder:Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        iso = Dynamic(value: try container.decode(String.self, forKey: .iso))
    }
}
