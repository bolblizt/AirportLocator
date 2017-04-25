//
//  Airport.swift
//  AiportLocator
//
//  Created by user on 18/4/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit

class Airport: NSObject {

    var airportXY:AirportLocation?
    var name:String?
    var country:String?
    var currency:String?
    var code:String?
    var countryCode:String?
    var timezone:String?
    var international:Bool
    var regional:Bool
    
    
    override init() {
        
        name = ""
        country = ""
        currency = ""
        code = ""
        countryCode = ""
        code = ""
        timezone = ""
        international = false
        regional = false
        
        
    }
    
    func titleLabel()->String{
        return country!
    }
    
    func subtitle()->String{
        return name!
    }
    
    
}
