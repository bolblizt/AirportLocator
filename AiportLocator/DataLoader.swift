//
//  DataLoader.swift
//  AiportLocator
//
//  Created by user on 19/4/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit
import Alamofire



class DataLoader: NSObject {
    
    //let urlStr = "https://www.qantas.com.au/api/airports"
    var thelist:[Airport]?
    var overLay:UIView?
    
    override init(){
        
    }
    
    
    func GetData(URL:String){
        
       // var result:Bool = false
        
        let queueUtility = DispatchQueue.global(qos: .utility)
        Alamofire.request(URL).responseJSON(queue:queueUtility ) { (response) in
            
            guard response.result.isSuccess else {
                print("Error while fetching tags: \(response.result.error)")
                //POST
                let nc = NotificationCenter.default
                nc.post(name: Notification.Name(rawValue: "errorFetching"), object: nil)
                return
            }
            
            guard let responseJSON = response.result.value as? [String: Any] else {
                
                print("Invalid tag information received from the service")
                return
            }
            
            print(responseJSON.count)
            
            if responseJSON.count > 0 {
                
               self.thelist = [Airport]()
                for item in responseJSON{
                    
                    
                    let jValues:NSArray = (item.value as? NSArray)!
                    
                    for airportItem in jValues{
                        let newAirport:Airport? = Airport()
                        let itemLists = airportItem as? NSDictionary
                        
                        if let code = itemLists?.value(forKey: "code"){
                            newAirport?.code = code as? String
                            
                        }
                        
                        if let display_name = itemLists?.value(forKey: "display_name"){
                            newAirport?.name = display_name as? String
                            
                        }
                        
                        if let international_airport = itemLists?.value(forKey: "international_airport"){
                            newAirport?.international = international_airport as! Bool
                        }
                        
                        if let regional_airport = itemLists?.value(forKey:"regional_airport" ){
                            newAirport?.regional = regional_airport as! Bool
                        }
                        
                        if let location = itemLists?.value(forKey: "location") as?  NSDictionary {
                            var xCoordinate:Double = 0.00
                            var yCoordinate:Double = 0.00
                            if let xlocation = location.value(forKey: "latitude"){
                                xCoordinate = xlocation as! Double
                            }
                            
                            if let yLocation = location["longitude"]{
                                yCoordinate = yLocation as! Double
                                
                            }
                            
                            newAirport?.airportXY = AirportLocation.init(latitude: xCoordinate, longitude: yCoordinate)
                        }
                        
                        if let currency_code  = itemLists?.value(forKey: "currency_code"){
                            newAirport?.currency = currency_code as? String
                        }
                        
                        if let timezone = itemLists?.value(forKey: "timezone"){
                            newAirport?.timezone = timezone as? String
                        }
                        
                         if let origin = itemLists?.value(forKey: "country") as?  NSDictionary {
                            
                            if let code = origin.value(forKey: "code"){
                                newAirport?.countryCode = code as? String
                            }

                            if let name = origin.value(forKey: "display_name"){
                                newAirport?.country = name as? String
                            }
                        }
                        self.thelist?.append(newAirport!)
                    }

                    
                    //add
                }
 
                
              
            }
            
            if (self.thelist?.count)! > 0 {
                
                print("list count: \(self.thelist?.count)")
                
                //POST
                let nc = NotificationCenter.default
                nc.post(name: Notification.Name(rawValue: "listOfAirports"), object: nil)

            }
            
            /*
             switch response.result {
             case .success:
             print("Validation Successful")
             
             case .failure(let error):
             print(error)
             }*/
        }
        

        
        
    }
    
    
    
    func AddOverLay(view:UIView)->UIView{
     
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        
        let rect = UIScreen.main.bounds
         var indicator:UIActivityIndicatorView!
        
        if self.overLay == nil{
            self.overLay = UIView(frame: rect)
            self.overLay!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.overLay!.backgroundColor = UIColor.white
            indicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            indicator.color = UIColor.darkGray
            indicator.frame = CGRect(x: (rect.size.width-50)/2, y: (rect.size.height-50)/2, width: 50, height: 50)
            indicator.hidesWhenStopped = true
            indicator.startAnimating()
            self.overLay?.addSubview(blurEffectView)
            self.overLay!.alpha = 0.8
            self.overLay!.addSubview(indicator)
            //self.view.addSubview(self.overLay!)
            //self.view.bringSubview(toFront: self.overLay!)
        }

        
        return overLay!
    }
    
    
       
    

}
