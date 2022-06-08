// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - MyTasksModel
struct MyTasksModel: Codable {
    let data: [MyTasksData]?
//    let total: Int?
//    let fromDate: String?
//    let toDate: JSONNull?
}

// MARK: - MyTasksData
struct MyTasksData: Codable {
    let id: Int?
    let baseTaskKey, status: String?
    let statusHistory: [StatusHistory]?
    let statusNotes: [JSONAny]?
    let awardProcess, billingMethod: String?
    let singleEditor: Bool?
    let orderPositionID, unitID: Int?
    let title: String?
    let descriptions: Descriptions?
    let taskDate, taskTime, taskEndTime, typeOfDate: String?
    let supplierTag: JSONNull?
    let geoLocation: GeoLocation?
    let tags: [JSONAny]?
    let releasedAt, createdAt, modifiedAt: String?
    let taskUsers: [TaskUser]?

    enum CodingKeys: String, CodingKey {
        case id, baseTaskKey, status, statusHistory, statusNotes, awardProcess, billingMethod, singleEditor
        case orderPositionID = "orderPositionId"
        case unitID = "unitId"
        case title, descriptions, taskDate, taskTime, taskEndTime, typeOfDate, supplierTag, geoLocation, tags, releasedAt, createdAt, modifiedAt, taskUsers
    }
}

// MARK: - Descriptions
struct Descriptions: Codable {
    let autoDefault, autoPreview, admin, descriptionsDefault: String?
    let preview, listAdmin, listDefault, listPreview: String?

    enum CodingKeys: String, CodingKey {
        case autoDefault, autoPreview, admin
        case descriptionsDefault = "default"
        case preview, listAdmin, listDefault, listPreview
    }
}

// MARK: - GeoLocation
struct GeoLocation: Codable {
    let type: String?
    let coordinates: [Double]?
}

// MARK: - StatusHistory
struct StatusHistory: Codable {
    let at, status: String?
}

// MARK: - TaskUser
struct TaskUser: Codable {
    let id, taskID: Int?
    let quantity: JSONNull?
    let taskRole, status: String?
    let statusHistory: [StatusHistory]?
    let userID: JSONNull?
    let contactID: Int?
    let externalEmail, externalAuthToken: JSONNull?
    let releaseDelay: Int?
    let releasedAt, acceptedAt: String?
    let declinedAt: String?
    let canceledAt: JSONNull?
    let supplierPriceData: SupplierPriceDataClass?
    let customSupplierPrice: Bool?
    let customSupplierPriceData, supplierOfferPriceData: CustomSupplierPriceDataClass?
    let travelDistanceData: TravelDistanceData?
    let travelFlatRatePriceData, travelDistancePriceData: SupplierPriceDataClass?
    let customTravelPrice: Bool?
    let customTravelPriceData, supplierOfferTravelPriceData: CustomSupplierPriceDataClass?
    let billingDetailID, travelCostsConditions: JSONNull?
    let comments: [Comment]?
    let tags: [JSONAny]?
    let pricePositions: PricePositions?

    enum CodingKeys: String, CodingKey {
        case id
        case taskID = "taskId"
        case quantity, taskRole, status, statusHistory
        case userID = "userId"
        case contactID = "contactId"
        case externalEmail, externalAuthToken, releaseDelay, releasedAt, acceptedAt, declinedAt, canceledAt, supplierPriceData, customSupplierPrice, customSupplierPriceData, supplierOfferPriceData, travelDistanceData, travelFlatRatePriceData, travelDistancePriceData, customTravelPrice, customTravelPriceData, supplierOfferTravelPriceData
        case billingDetailID = "billingDetailId"
        case travelCostsConditions, comments, tags
        case pricePositions = "_pricePositions"
    }
}

// MARK: - Comment
struct Comment: Codable {
    let id, text: String?
    let userID: Int?
    let modifiedAt, userOutputName: String?

    enum CodingKeys: String, CodingKey {
        case id, text
        case userID = "userId"
        case modifiedAt, userOutputName
    }
}

// MARK: - CustomSupplierPriceDataClass
struct CustomSupplierPriceDataClass: Codable {
    let basePrice: Double?
}

// MARK: - PricePositions
struct PricePositions: Codable {
    let supplierPrices: JSONNull?
    let travelDistancePrices, travelTimePrices: [TravelEPrice]?
    let travelFlatRatePrices: [TravelFlatRatePrice]?
}

// MARK: - TravelEPrice
struct TravelEPrice: Codable {
    let pricePerUnit, total, quantity: Double?
    let info: TravelDistancePriceInfo?
}

// MARK: - TravelDistancePriceInfo
struct TravelDistancePriceInfo: Codable {
}

// MARK: - TravelFlatRatePrice
struct TravelFlatRatePrice: Codable {
    let pricePerUnit, total, quantity: Int?
    let info: TravelFlatRatePriceInfo?
}

// MARK: - TravelFlatRatePriceInfo
struct TravelFlatRatePriceInfo: Codable {
    let originalQuantity: Double?
    let flatRate: Bool?
}

// MARK: - SupplierPriceDataClass
struct SupplierPriceDataClass: Codable {
    let periods: [JSONAny]?
    let flatRate: Bool?
    let basePrice: Double?
    let usePeriods: UsePeriods?
    let quantityPrices: [QuantityPrice]?
}

// MARK: - QuantityPrice
struct QuantityPrice: Codable {
    let id: String?
    let value, quantity: Int?
    let usePeriods, kindOfValue: String?
}

enum UsePeriods: String, Codable {
    case no = "no"
}

// MARK: - TravelDistanceData
struct TravelDistanceData: Codable {
    let recommended, shortestDistance, shortestDuration: Recommended?
}

// MARK: - Recommended
struct Recommended: Codable {
    let distance, duration: Distance?
}

// MARK: - Distance
struct Distance: Codable {
    let text: String?
    let value: Int?
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
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

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}

