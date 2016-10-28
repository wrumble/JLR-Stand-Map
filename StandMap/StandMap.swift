//
//  StandMap.swift
//  StandMap
//
//  Created by Wayne Rumble on 22/08/2016.
//  Copyright © 2016 Wayne Rumble. All rights reserved.
//

import Foundation
import Freddy

struct StandMap {
    
    let title: String
    let mapImage: String
    
}

extension StandMap: JSONDecodable {
    
    init(json: JSON) throws {
        title = try json.string("titleText")
        mapImage = try json.string("mapImageFileName")
    }
    
}

extension StandMap {
    
    static func build(completion: ([StandMap]) -> ()) {
        let standMapData = NSData(contentsOfURL: NSBundle.mainBundle().URLForResource("StandMap", withExtension: "json")!)!
        do {
            let json = try JSON(data: standMapData)
            let standMap: [StandMap] = try json.array("StandMap").map(StandMap.init)
            completion(standMap)
        } catch {
            fatalError("Failed to load Stand Map from json file")
        }
    }
}
