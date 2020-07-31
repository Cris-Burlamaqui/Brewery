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
    
    var contentView: BeerBatchView!

    override func setUpWithError() throws {
        
        contentView = BeerBatchView()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func firstSolution() throws {
        
        let correctBeerBatch = ["C", "C", "C", "C", "B"]
        let clientsList = ["5", "1 B 3 C 5 C", "2 C 3 B 4 C", "5 B"]
        
        contentView.generateBeerList(from: clientsList)
        
        XCTAssertEqual(correctBeerBatch, contentView.beerBatch)
    }
    
    func secondSolution() throws {

        let correctBeerBatch = ["B", "B"]
        let clientsList = ["2", "1 C 2 B", "1 B"]

        contentView.generateBeerList(from: clientsList)

        XCTAssertEqual(correctBeerBatch, contentView.beerBatch)
    }

    func noSolution() throws {

        let correctBeerBatch = [String]()
        let clientsList = ["1", "1 C", "1 B"]

        contentView.generateBeerList(from: clientsList)

        XCTAssertEqual(correctBeerBatch.isEmpty, contentView.beerBatch.isEmpty)
    }

    func secondNoSolution() throws {

        let correctBeerBatch = [String]()
        let clientsList = ["2", "1 C 2 B", "1 B", "2 C"]

        contentView.generateBeerList(from: clientsList)

        XCTAssertEqual(correctBeerBatch, contentView.beerBatch)
    }

}
