//
//  SpeedAverageTests.swift
//  SpeedAverageTests
//
//  Created by WJ on 15/10/27.
//  Copyright © 2015年 wj. All rights reserved.
//

import XCTest
@testable import SpeedAverage

class SpeedAverageTests: XCTestCase {
    var calculator: MovingAverageCalculator = NaiveMovingAverageCalculator()
    
    override func setUp() {
        super.setUp()
        
//        calculator = BetterMovingAverageCalculator()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCopesWithEmptyArray(){
        let result = calculator.calculateMovingAverage([])
        XCTAssertEqual(result.count, 0)
    }
    
    func testCopesWithArrayShorterThanWindow() {
        calculator.windowSize = 5
        let result = calculator.calculateMovingAverage([1.0, 2.0])
        XCTAssertEqual(result.count, 0)
    }
    
    func testHasCorrectBehaviour() {
        calculator.windowSize = 4
        let input = [1.0, 2.0, 3.0, 4.0, 5.0, 5.0, 5.0, 6.0, 2.0, 2.0]
        let expected = [2.5, 3.5, 4.25, 4.75, 5.25, 4.5, 3.75]
        let result = calculator.calculateMovingAverage(input)
        XCTAssertEqual(result.count, expected.count)
        if(result.count == expected.count) {
            for i in 0..<expected.count {
                XCTAssertEqual(result[i], expected[i])
            }
        }
    }
    
    func testMovingAveragePerformance() {
        // This is an example of a performance test case.
        calculator.windowSize = 1000
        self.measureBlock() {
            // Put the code you want to measure the time of here.
            let randomArray = self.RandomDouble(10000)
            let result = self.calculator.calculateMovingAverage(randomArray)
            XCTAssertEqual(result.count, 9000)
        }
    }
    
    
    func RandomDouble(length: Int) -> Array<Double> {
        srand48(time(nil))
        
        var result = [Double]()
        for _ in 1..<length {
            result.append(drand48())
        }
        return result
    }
}
