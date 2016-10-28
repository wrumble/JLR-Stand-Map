//
//  ViewController.swift
//  StandMap
//
//  Created by Wayne Rumble on 22/08/2016.
//  Copyright © 2016 Wayne Rumble. All rights reserved.
//

import UIKit

class StandMapViewController: UIViewController {
    
    var standMap: StandMap!
    var hotspots: [Hotspot] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Hotspot.all { hotspot in
            hotspot.forEach(self.assignHotspotVariable)
        }
        
        StandMap.build {standMap in
            standMap.forEach(self.assignStandMapVariable)
        }
        
        viewForStandMap(standMap, hotspots: hotspots)
                
    }
    
    private func assignStandMapVariable(standMap: StandMap) {
        self.standMap = standMap
    }
    
    private func assignHotspotVariable(hotspot: Hotspot) {
        hotspots.append(hotspot)
    }
    
    private func viewForStandMap(standMap: StandMap, hotspots: [Hotspot]) {
        let standMapView = StandMapView()
        standMapView.translatesAutoresizingMaskIntoConstraints = false
        standMapView.bind(standMap, hotspots: hotspots)
        view.addSubview(standMapView)
        standMapView.snp_makeConstraints { make in
         make.edges.equalTo(view.snp_edges)
        }
    }
}

