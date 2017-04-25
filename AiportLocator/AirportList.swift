//
//  AirportList.swift
//  AiportLocator
//
//  Created by user on 19/4/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit

class AirportList: NSObject {
    
    var rows:Int = 0
    var section:Int = 0
   private var airportList:[Airport]?
    var fullList:NSArray?
    var tempoList:NSMutableArray?
    var remainingRows:Int = 0
    var currentItems:Int = 0
    var lastItems:Int = 0
    
    
    
    func AddRows()->Int{
        remainingRows = rows
    
        return remainingRows
    }
    
    func rowsTable()->Int{
        if currentItems == 0{
            currentItems = 50
        }
        
        return currentItems
    }
    
    func sectionTable()->Int{
    return section
    
    }
    
    
     init(tableRows:Int, tableSection:Int, airports:[Airport]){
        rows = tableRows
        section = tableSection
        airportList = airports
       
        
    }
    
    func getAirportList()->[Airport]{
        
        return self.airportList!
    }
    
    func tableCell(index:IndexPath, tableView:UITableView)->UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "airports", for: index) as UITableViewCell
        
        cell.textLabel?.text = getAirportName(indexPath: index)
        cell.detailTextLabel?.text = getAirportCountry(indexPath: index)
        
        return cell
        
    }
    
    
    func getAirportName(indexPath:IndexPath)-> String{
        
        let airport = self.tempoList?.object(at: indexPath.row) as! Airport
        
        guard let name = airport.name else {
            
            return ""
        }
        
        
    return name
    }
    
    func getAirportCountry(indexPath:IndexPath)-> String{
     
        let airport = self.tempoList?.object(at: indexPath.row) as! Airport
        
        guard let country = airport.country else {
            
            return ""
        }
        
        
        return country
    }
    

    func ConvertArray(){
        
    
        self.fullList = NSArray(array: self.airportList!)
       
    }
    
    
    func SubArray() -> [Airport]{
        var tempArray:[Airport]? 
        var tempTotal = 0
        var len = 0
        
        if self.currentItems < rows{
            len = 50
            tempArray = self.fullList?.subarray(with: NSMakeRange(currentItems, len)) as! [Airport]?
            self.lastItems = currentItems
            self.currentItems += 50
        }
        else
        {
            tempTotal =  rows - currentItems
            len = tempTotal
            tempArray = self.fullList?.subarray(with: NSMakeRange(currentItems, len)) as! [Airport]?
            self.lastItems = currentItems
            self.currentItems += len
            
        }
        
        
        return tempArray! 
    }
    
    func AddNewItems(airports:[Airport]){
       
        if self.tempoList == nil{
            self.tempoList = NSMutableArray()
        }
       // else{
             self.tempoList?.addObjects(from: airports)
       // }
       
    }
    
    
    func ProcessArray()->[Airport]{
        let myArrays = SubArray()
        AddNewItems(airports: myArrays)
        
        return myArrays
    }
    
    
   
    
    
}
