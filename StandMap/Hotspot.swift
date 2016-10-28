//
//  Hotspot.swift
//  StandMap
//
//  Created by Wayne Rumble on 22/08/2016.
//  Copyright © 2016 Wayne Rumble. All rights reserved.
//

import Foundation
import Freddy

struct Hotspot {
    
    let title: String
    let text: String
    let image: String
    let titleXCoordinate: Double
    let titleYCoordinate: Double
    let hotspotXCoordinate: Double
    let hotspotYCoordinate: Double
    
}

extension Hotspot: JSONDecodable {
    
    init(json: JSON) throws {
        title = try json.string("title")
        text = try json.string("text")
        image = try json.string("image")
        titleXCoordinate = try json.double("titleXCoordinate")
        titleYCoordinate = try json.double("titleYCoordinate")
        hotspotXCoordinate = try json.double("hotspotXCoordinate")
        hotspotYCoordinate = try json.double("hotspotYCoordinate")
    }
    
}

extension Hotspot {
    
    static func all(completion: ([Hotspot]) -> ()) {
        let hotspotData = NSData(contentsOfURL: NSBundle.mainBundle().URLForResource("StandMap", withExtension: "json")!)!
        do {
            let json = try JSON(data: hotspotData)
            let hotspots: [Hotspot] = try json.arrayOf("StandMap", 0, "hotspots")
            completion(hotspots)
        } catch {
            fatalError("Failed to load Show Guide Hotspots from json file")
        }
    }
}


