////////////////////////////////////////////////////////////////////////////
//
// Copyright 2014 Realm Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
////////////////////////////////////////////////////////////////////////////

import Foundation
import Realm

// These types don't change when wrapping in Swift
// so we just typealias them to remove the 'RLM' prefix

// MARK: Aliases

/**
 `PropertyType` is an enum describing all property types supported in Realm models.

 For more information, see [Realm Models](https://realm.io/docs/swift/latest/#models).

 ### Primitive types

 * `Int`
 * `Bool`
 * `Float`
 * `Double`

 ### Object types

 * `String`
 * `Data`
 * `Date`

 ### Relationships: Array (in Swift, `List`) and `Object` types

 * `Object`
 * `Array`
*/
public typealias PropertyType = RLMPropertyType

/**
 An opaque token which is returned from methods which subscribe to changes to a Realm.

 - see: `Realm.observe(_:)`
 */
public typealias NotificationToken = RLMNotificationToken

@objc(RealmSwiftObjectId)
public final class ObjectId: RLMObjectId, Codable {
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        try super.init(string: container.decode(String.self))
    }
    public func encode(to encoder: Encoder) throws {
        try self.stringValue.encode(to: encoder)
    }

    public override required init() {
        super.init()
    }

    public override required init(string: String) throws {
        try super.init(string: string)
    }
    public required init(_ str: StaticString) {
        try! super.init(string: str.withUTF8Buffer { String(decoding: $0, as: UTF8.self) })
    }
}

@objc(RealmSwiftDecimal128)
public final class Decimal128: RLMDecimal128, Codable {
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let strValue = try? container.decode(String.self) {
            try super.init(string: strValue)
        } else if let intValue = try? container.decode(Int64.self) {
            super.init(number: intValue as NSNumber)
        } else if let doubleValue = try? container.decode(Double.self) {
            super.init(number: doubleValue as NSNumber)
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot convert value to Decimal128")
        }
    }
    public func encode(to encoder: Encoder) throws {
        try self.stringValue.encode(to: encoder)
    }

    public override required init() {
        super.init()
    }
    public override required init(nsDecimal: NSDecimalNumber) {
        super.init(nsDecimal: nsDecimal)
    }
    public override required init(number: NSNumber) {
        super.init(number: number)
    }
    public override required init(string: String) throws {
        try super.init(string: string)
    }
}

extension Decimal128: ExpressibleByIntegerLiteral {
    public convenience init(integerLiteral value: Int64) {
        self.init(number: value as NSNumber)
    }
}

extension Decimal128: ExpressibleByFloatLiteral {
    public convenience init(floatLiteral value: Double) {
        self.init(number: value as NSNumber)
    }
}

extension Decimal128: ExpressibleByStringLiteral {
    public convenience init(stringLiteral value: String) {
        try! self.init(string: value)
    }
}

