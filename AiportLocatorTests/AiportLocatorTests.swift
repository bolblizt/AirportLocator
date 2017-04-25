//
//  AiportLocatorTests.swift
//  AiportLocatorTests
//
//  Created by user on 18/4/17.
//  Copyright © 2017 user. All rights reserved.
//

import XCTest

@testable import AiportLocator

class AiportLocatorTests: XCTestCase {
    
     var vc:ViewController! = nil
    let downloader:DataLoader = DataLoader()

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        vc = storyboard.instantiateViewController(withIdentifier: "MainView")  as! ViewController
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
   
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            XCTAssertNotNil(self.downloader.GetData(URL: "https://www.qantas.com.au/api/airports"))
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetData(){
        
       // let downloader:DataLoader = DataLoader()
        XCTAssertNotNil(self.downloader.GetData(URL: "https://www.qantas.com.au/api/airports"))
    }
    
    func testAirportList(){
        let temp:Airport = Airport()
        let airport = AirportList(tableRows: 1, tableSection: 0, airports: [temp])
        XCTAssertNotNil(airport)
       
    }
    
    func testSetupData(){
        
        XCTAssert(self.vc.setupData(dataLoader:self.downloader))
    }
    
    func testDetailView(){
        
        let tempAirport = Airport()
        let detailView = AirportDetailView(airportModel:tempAirport )
        XCTAssertNotNil(detailView.setLabel(descript: "China", label: "Country", labelSize: 12.0, descriptSize: 15.0))
        
        
    }
    
}
