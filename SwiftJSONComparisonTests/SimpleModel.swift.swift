//
//  SimpleModel.swift.swift
//  SwiftJSONComparisonTests
//
//  Created by ZhangChi on 2021/12/18.
//

import Foundation
import SwiftyJSON
import JASON
import ObjectMapper
import HandyJSON


struct SimpleModel {
  let id: Int
  let name: String
  let friends: [String]
  let edu: [String: String]
  let likes: [String: Bool]
}

extension SimpleModel {
  init(swiftyJson json: SwiftyJSON.JSON) {
    id = json["id"].intValue
    name = json["name"].stringValue
    friends = json["friends"].arrayValue.map { $0.stringValue }
    edu = json["edu"].dictionaryValue.mapValues {  $0.stringValue }
    likes = json["likes"].dictionaryValue.mapValues { $0.boolValue }
  }
}

extension SimpleModel {
  init(jasonJson json: JASON.JSON) {
    id = json["id"].intValue
    name = json["name"].stringValue
    friends = json["friends"].jsonArrayValue.map { $0.stringValue }
    edu = json["edu"].jsonDictionaryValue.mapValues {  $0.stringValue }
    likes = json["likes"].jsonDictionaryValue.mapValues { $0.boolValue }
  }
}

struct ObjMpSimpleModel: Mappable {
  var id: Int?
  var name: String?
  var friends: [String]?
  var edu: [String: String]?
  var likes: [String: Bool]?
  
  init?(map: Map) { }
  mutating func mapping(map: Map) {
    id      <-  map["id"]
    name    <-  map["name"]
    friends <-  map["friends"]
    edu     <-  map["edu"]
    likes   <-  map["likes"]
  }
}

struct HdySimpleModel: HandyJSON {
  var id: Int?
  var name: String?
  var friends: [String]?
  var edu: [String: String]?
  var likes: [String: Bool]?
}

struct CodableSimpleModel: Codable {
  let id: Int
  let name: String
  let friends: [String]
  let edu: [String: String]
  let likes: [String: Bool]
}
