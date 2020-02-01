//
//  HolidayViewModel.swift
//  HolidayApi
//
//  Created by Ethan on 2020/1/29.
//  Copyright © 2020 playplay. All rights reserved.
//

import Foundation


class HolidayListViewModel:Decodable{

    var response:HolidaysViewModel

    var numberOfRows:Int {
        return response.holidays.count
    }
    
    func getHoliday(_ index:Int) -> Holiday {
        return self.response.holidays[index]
    }

}

class HolidaysViewModel:Decodable{
    let holidays:[Holiday]
}


