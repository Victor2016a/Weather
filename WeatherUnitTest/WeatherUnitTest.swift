//
//  WeatherUnitTest.swift
//  WeatherUnitTest
//
//  Created by Victor Vieira on 19/05/22.
//

@testable import Weather
import XCTest

class WeatherUnitTest: XCTestCase {
  
  var apiService: ApiService?
  
  override func setUp() {
    super.setUp()
    apiService = ApiService()
  }
  
  override func tearDown() {
    apiService = nil
    super.tearDown()
  }
}
