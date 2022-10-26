//
//  Configuration.swift
//  Water Project
//
//  Created by Yura Yatseyko on 17.10.2021.
//

import Foundation

// MARK: - Configuration

final class Configuration {

    // MARK: - Properties

    private let config: NSDictionary

    // MARK: - Init

    init(dictionary: NSDictionary) {
        config = dictionary
    }
    
    convenience init() {
        let bundle = Bundle.main
        let configPath = bundle.path(forResource: "Configuration", ofType: "plist")!
        let config = NSDictionary(contentsOfFile: configPath)!
        
        let dict = NSMutableDictionary()
        if let configs = config[Bundle.main.infoDictionary?["Configuration"] ?? ""] as? [AnyHashable: Any] {
            dict.addEntries(from: configs)
        }
        
        self.init(dictionary: dict)
    }
}

extension Configuration {
    var environment: String {
        return config["environment"] as! String
    }
    
    var apiURL: String {
        return config["apiURL"] as! String
    }
}
