//
//  GeneralApiModel.swift
//  BaseDemo
//
//  Created by Moontechnolabs on 26/04/23.
//

import Foundation

struct Model_APIResponse<M:Decodable> : Decodable {
    
    private enum CodingKeys: String, CodingKey { case success, result, msg }
    let result : M?
    let msg : String?
    let success : Bool?
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decode(Bool.self, forKey: .success)
        msg = try values.decode(String.self, forKey: .msg)
        if success ?? false {
            result = try values.decode(M.self, forKey: .result)
        }else{
            result = nil
        }
    }
}
struct EmtyModel : Codable {
    
}
//struct userName: Codable {
//    let name: String?
//    enum CodingKeys: String, CodingKey {
//        case name = "first_name"
//    }
//}
func objectFrom<D,Model:Codable>(dic: D, completion: (Model?) -> Void){
    //Where D is dictionary || array of dictionary
    do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let jsonData = try JSONSerialization.data(withJSONObject: dic, options: [])
        let objModel = try decoder.decode(Model.self, from: jsonData)
        completion(objModel)
    } catch let myJSONError {
        print(myJSONError)
        print(myJSONError.localizedDescription)
        completion(nil)
    }
}
// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(0)
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
