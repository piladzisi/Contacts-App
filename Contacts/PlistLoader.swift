//
//  PlistLoader.swift
//  Contacts
//
//  Created by anna.sibirtseva on 24/04/2019.
//  Copyright © 2019 anna.sibirtseva. All rights reserved.
//

import Foundation


enum PlistError: Error {
    case invalidResource
    case parsingFailure
}

class PlistLoader {
    static func array(fromFile name: String, ofType type: String) throws -> [[String: String]] {
        guard let path = Bundle.main.path(forResource: name, ofType: type) else {
            throw PlistError.invalidResource
        }
        
        guard let array = NSArray(contentsOfFile: path) as? [[String: String]] else {
            throw PlistError.parsingFailure
        }
        
        return array
    }
}

class ContactsSource {
    static var contacts: [Contact] {
        let data = try! PlistLoader.array(fromFile: "ContactsDB", ofType: "plist")
        return data.compactMap { Contact(dictionary: $0) }
    }
    
}
