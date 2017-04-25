//
//  AirportDetailView.swift
//  AiportLocator
//
//  Created by user on 19/4/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit
import MapKit
class AirportDetailView: NSObject {
    
   private let selectedAirport:Airport?
    
    init(airportModel:Airport) {
        self.selectedAirport = airportModel
    }
    
    
    func GotoPin()->MKCoordinateRegion{
        let latDelta: CLLocationDegrees = 0.3
        let lonDelta: CLLocationDegrees = 0.3
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake((self.selectedAirport?.airportXY?.lat)!, (self.selectedAirport?.airportXY?.lon)!)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        return region
    }
    
    func MapAnnotate()->MapAnnotation{
      
        let annotation:MapAnnotation = MapAnnotation(title: self.selectedAirport!.name!, coordinate:   CLLocationCoordinate2D(latitude: (self.selectedAirport!.airportXY?.lat)!, longitude: (self.selectedAirport!.airportXY?.lon)!), info: self.selectedAirport!.countryCode!)
        
        return annotation
    }
    
    
    
    func Country()->String{
        
        return (self.selectedAirport?.country)!
    }
    
    func AirportName() -> String{
       
        return (self.selectedAirport?.name)!
    }
    
    
    func AiportLocation()->AirportLocation{
        
        return (self.selectedAirport?.airportXY)!
    }
    
    
    func AirportCurrency()->String{
        return (self.selectedAirport?.currency)!
    }
    
    func AiportCode() ->String{
        return (self.selectedAirport?.code)!
    }
    
    func AirportTimezone()->String{
        return (self.selectedAirport?.timezone)!
    }
    
    func Regional()->Bool{
        return (self.selectedAirport?.regional)!
    }
    
    func International()->Bool{
        return (self.selectedAirport?.international)!
    }

    
    func setLabel(descript:String, label:String, labelSize:CGFloat, descriptSize:CGFloat)->NSMutableAttributedString{
        let yourAttributes = [NSForegroundColorAttributeName: UIColor.lightGray, NSFontAttributeName: UIFont.systemFont(ofSize: labelSize)]
        let yourOtherAttributes = [NSForegroundColorAttributeName: UIColor.darkGray, NSFontAttributeName: UIFont.systemFont(ofSize: descriptSize)]
        
        let partOne = NSMutableAttributedString(string:  label, attributes: yourAttributes)
        let partTwo = NSMutableAttributedString(string: descript, attributes: yourOtherAttributes)
        
        let combination = NSMutableAttributedString()
        
        combination.append(partOne)
        combination.append(partTwo)
        
        return combination
    }
    
}
