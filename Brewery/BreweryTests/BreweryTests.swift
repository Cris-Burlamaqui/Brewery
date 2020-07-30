//
//  BreweryTests.swift
//  BreweryTests
//
//  Created by Cris Burlamaqui on 28/07/2020.
//  Copyright © 2020 Cris Burlamaqui. All rights reserved.
//

import XCTest
@testable import Brewery

class BreweryTests: XCTestCase {
    
    var contentView: ContentView!

    override func setUpWithError() throws {
        
        contentView = ContentView()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func firstSolution() throws {
        
        let correctBeerBatch = ["C", "C", "C", "C", "B"]
        let clientList = ["5", "1 B 3 C 5 C", "2 C 3 B 4 C", "5 B"]
        
        contentView.generateBeerList(from: clientList)
        
        XCTAssertEqual(correctBeerBatch, contentView.beerBatch)
    }
    
    func secondSolution() throws {

        let correctBeerBatch = ["B", "B"]
        let clientList = ["2", "1 C 2 B", "1 B"]

        contentView.generateBeerList(from: clientList)

        XCTAssertEqual(correctBeerBatch, contentView.beerBatch)
    }

    func noSolution() throws {

        let correctBeerBatch = [String]()
        let clientList = ["1", "1 C", "1 B"]

        contentView.generateBeerList(from: clientList)

        XCTAssertEqual(correctBeerBatch.isEmpty, contentView.beerBatch.isEmpty)
    }

}
