//
//  Order.swift
//  CupcakeCorner
//
//  Created by Bruce Wang on 2024/1/3.
//

import Foundation

@Observable
class Order: Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _streetAddress = "streetAddress"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _city = "city"
        case _name = "name"
        case _zip = "zip"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
    }
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = "" {
        didSet {
            UserDefaults.standard.setValue(name, forKey: "name")
        }
    }
    var streetAddress = "" {
        didSet {
            UserDefaults.standard.setValue(streetAddress, forKey: "streetAddress")
        }
    }
    var city = "" {
        didSet {
            UserDefaults.standard.setValue(city, forKey: "city")
        }
    }
    var zip = "" {
        didSet {
            UserDefaults.standard.setValue(zip, forKey: "zip")
        }
    }
    
    var hasValidAddress: Bool {
        if name.trimmingCharacters(in: .whitespaces).isEmpty
            || streetAddress.trimmingCharacters(in: .whitespaces).isEmpty
            || city.trimmingCharacters(in: .whitespaces).isEmpty
            || zip.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        }
        return true
    }
    
    var cost: Decimal {
        // $2 per cake
        var cost = Decimal(quantity) * 2

        // complicated cakes cost more
        cost += (Decimal(type) / 2)

        // $1/cake for extra frosting
        if extraFrosting {
            cost += Decimal(quantity)
        }

        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }

        return cost
    }
    init() {
        load()
    }
    
    func load() {
        if let tmp = UserDefaults.standard.string(forKey: "name") {
            name = tmp
        }
        if let tmp = UserDefaults.standard.string(forKey: "city") {
            city = tmp
        }
        if let tmp = UserDefaults.standard.string(forKey: "zip") {
            zip = tmp
        }
        if let tmp = UserDefaults.standard.string(forKey: "streetAddress") {
            streetAddress = tmp
        }
        
    }
}
