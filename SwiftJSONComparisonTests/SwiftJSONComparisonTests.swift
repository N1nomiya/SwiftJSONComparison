//
//  SwiftJSONComparisonTests.swift
//  SwiftJSONComparisonTests
//
//  Created by ZhangChi on 2021/12/18.
//

import XCTest
@testable import SwiftJSONComparison

import SwiftyJSON
import JASON
import ObjectMapper
import HandyJSON

class SwiftJSONComparisonTests: XCTestCase {
  
  let data = loadData()
  let json = loadJSON()
  let jStr = loadJSONStr()
  
  func testSwiftyJSON10000() throws {
    self.measure {
      for _ in 0..<10000 {
        let json = SwiftyJSON.JSON(json)
        _ = SimpleModel(swiftyJson: json)
      }
    }
  }
  
  func testJason10000() throws {
    self.measure {
      for _ in 0..<10000 {
        let json = JASON.JSON(json)
        _ = SimpleModel(jasonJson: json)
      }
    }
  }
  
  func testObjectMapper10000() throws {
    self.measure {
      for _ in 0..<10000 {
        _ = ObjMpSimpleModel(JSONString: jStr)
      }
    }
  }
  
  func testHandyJSON10000() throws {
    self.measure {
      for _ in 0..<10000 {
        _ = HdySimpleModel.deserialize(from: jStr)
      }
    }
  }
  
  func testCodable10000() throws {
    let decoder = JSONDecoder()
    self.measure {
      for _ in 0..<10000 {
        _ = try? decoder.decode(CodableSimpleModel.self, from: data)
      }
    }
  }
}


fileprivate func loadData() -> Data {
  let path = Bundle.main.path(forResource: "simple", ofType: "json")!
  let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .uncached)
  return data
}

fileprivate func loadJSON() -> Any {
  return try! JSONSerialization.jsonObject(with: loadData())
}

fileprivate func loadJSONStr() -> String {
  return String(data: loadData(), encoding: .utf8)!
}

