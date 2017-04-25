//
//  ViewController.swift
//  AiportLocator
//
//  Created by user on 18/4/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    @IBOutlet weak var tableList:UITableView?
     var airportViewModel:AirportList?
     var viewOverlay: UIView!
     var  dataLoader:DataLoader?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Airports®"
       self.PrepOperation()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK: - Tableviews
    
    //sections
    func numberOfSections(in tableView: UITableView) -> Int {
        let section:Int = (airportViewModel?.sectionTable())!
        return section
    }
    
    //rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows:Int = (airportViewModel?.rowsTable())! //(airportViewModel?.rowsTable())!
        print(rows)
        return rows
    }
    
    //set table cell
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let rows:Int =  (self.airportViewModel?.rowsTable())!
        
        if (indexPath.row < rows) {
            print("dismiss")
            self.Overlay(start: false)
        }
        
        let cell:UITableViewCell = (airportViewModel?.tableCell(index: indexPath, tableView: tableView))!
        
        return cell
    }
    
    //row height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let rowHeight:CGFloat = 50.0
        return rowHeight
    }
    
    
    //select
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
   
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == airportViewModel?.tempoList?.count{
            
        }
        
    }
    
    //MARK: - Scroll Delegates
    
     func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
    
     func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let newList =  self.airportViewModel?.ProcessArray()
        AddNewRows(tableView: self.tableList!, theList: newList!)
        
    }
    
    func AddNewRows(tableView:UITableView, theList:[Airport]){
     
        var i:Int = (self.airportViewModel?.lastItems)!
        var indexs:[IndexPath] = [IndexPath]()
        while i < (self.airportViewModel?.currentItems)!{
            let newIndex = IndexPath(row: i, section: 0)
            indexs.append(newIndex)
            i += 1
        }
        
        tableView.beginUpdates()
        tableView.insertRows(at: indexs, with: .none )
        tableView.endUpdates()
    }
    
    
    
    func PrepOperation(){
        
         self.dataLoader = DataLoader()
        
        DispatchQueue.main.async {
            self.viewOverlay = self.dataLoader?.AddOverLay(view: self.view)
            self.view.addSubview(self.viewOverlay)
            self.view.bringSubview(toFront: self.viewOverlay)
            self.Overlay(start: true)
                
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.setTheTable), name: NSNotification.Name(rawValue: "listOfAirports"), object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.AlertMsg), name: NSNotification.Name(rawValue: "errorFetching"), object: nil)

    _ =  self.setupData(dataLoader: dataLoader!)
        
        

    }
    
    func AlertMsg(){
        
        let alertView = UIAlertController(title: "Airport Locator", message: "Please check your internet connection", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
            print("OK")
            self.Overlay(start: false)
        }
        alertView.addAction(okAction)
        self.present(alertView, animated: true, completion: nil)
        
    }
    
    func setTheTable(){
        self.airportViewModel = AirportList(tableRows: (self.dataLoader?.thelist?.count)!, tableSection: 1, airports: (self.dataLoader?.thelist!)!)
        self.airportViewModel?.ConvertArray()
        _ = self.airportViewModel?.ProcessArray()
        self.tableList?.delegate = self
        self.tableList?.dataSource = self
        DispatchQueue.main.async {
            self.tableList?.reloadData()
        }

    }
    
    
    func setupData(dataLoader:DataLoader)-> Bool{
        var result: Bool = false
        dataLoader.GetData(URL: "https://www.qantas.com.au/api/airports")
        result = true
        return result
    }
    
    
    func Overlay(start:Bool){
        
        if start {
            UIView.animate(withDuration: 2.5, delay: 0.0, options: UIViewAnimationOptions(), animations: { () -> Void in
                
                self.viewOverlay!.alpha = 0.8
                
            }, completion: { (finished: Bool) -> Void in
                
                // you can do this in a shorter, more concise way by setting the value to its opposite, NOT value
            })
        }
        else
        {
            UIView.animate(withDuration: 2.5, delay: 0.0, options: UIViewAnimationOptions(), animations: { () -> Void in
                
                self.viewOverlay!.alpha = 0.0
                
            }, completion: { (finished: Bool) -> Void in
                
                // you can do this in a shorter, more concise way by setting the value to its opposite, NOT value
            })
        }
    }
    
    override   func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        return true
    }
    
    override   func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "airportDetails" {
            
            //Initial your second view data control
            let selectedIndex = self.tableList?.indexPathForSelectedRow
            let airportDetail = segue.destination as! AirportDetailViewController
            let selectedAirport =  self.airportViewModel?.tempoList?.object(at: (selectedIndex?.row)!) as! Airport?
            //Send your data with segue
            airportDetail.airportDetail = AirportDetailView(airportModel: selectedAirport!)
        }
        
        
    }
    
    
    

}

