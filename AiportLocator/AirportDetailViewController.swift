//
//  AirportDetailViewController.swift
//  AiportLocator
//
//  Created by user on 19/4/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit
import MapKit

class AirportDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel:UILabel?
    @IBOutlet weak var countryLabel:UILabel?
    @IBOutlet weak var code:UILabel?
    @IBOutlet weak var timezone:UILabel?
    @IBOutlet weak var currency:UILabel?
    @IBOutlet weak var interAirport:UILabel?
    @IBOutlet weak var regAirport:UILabel?
    @IBOutlet weak var map:MKMapView?
    var airportDetail:AirportDetailView?
    
    @IBAction func CloseView(){
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
             self.setup(airport: self.airportDetail!)
        }
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setup(airport:AirportDetailView){
        self.titleLabel?.text = airport.AirportName()
        self.countryLabel?.text = airport.Country()
        self.map?.addAnnotation(airport.MapAnnotate())
        self.map?.setRegion(airport.GotoPin(), animated: true)
        self.code?.attributedText = airport.setLabel(descript:airport.AiportCode() , label:"Code: ", labelSize:15, descriptSize:17)
        self.timezone?.attributedText = airport.setLabel(descript:airport.AirportTimezone() , label: "Timezone: ", labelSize:15, descriptSize:17)
        self.currency?.attributedText = airport.setLabel(descript: airport.AirportCurrency() , label:"Currency: ", labelSize:15, descriptSize:17)
        
        self.interAirport?.attributedText = airport.setLabel(descript: "NO", label: "International Airport: ", labelSize:12, descriptSize:15)
        if airport.International(){
            self.interAirport?.attributedText = airport.setLabel(descript: "YES", label: "International Airport: ", labelSize:12, descriptSize:15)
        }
        
         self.regAirport?.attributedText = airport.setLabel(descript: "NO", label: "Regional Aiport: ", labelSize:12, descriptSize:15)
        if airport.Regional(){
            self.regAirport?.attributedText = airport.setLabel(descript: "YES", label: "Regional Aiport: ", labelSize:12, descriptSize:15)
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
