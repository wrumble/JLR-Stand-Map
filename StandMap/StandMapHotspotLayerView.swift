//
//  StandMapHotspotLayerView.swift
//  StandMap
//
//  Created by Wayne Rumble on 26/08/2016.
//  Copyright © 2016 Wayne Rumble. All rights reserved.
//

import UIKit
import OAStackView

protocol StandMapHotspotLayerViewDataSource {
    
    func numberOfHotspots(standMapHotspotLayerView: StandMapHotspotLayerView) -> Int
    
    func hotspotViewForIndex(index: Int, inStandMapHotspotLayerView: StandMapHotspotLayerView) -> (UIImageView, OAStackView)
}

struct HotspotViews {
    
    var stackView: [OAStackView] = []
    var hotspotView: [UIImageView] = []
}

class StandMapHotspotLayerView: UIView {
    
    var dataSource: StandMapHotspotLayerViewDataSource?
    var hotspotViews = HotspotViews()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let hotspotCount = self.dataSource?.numberOfHotspots(self) ?? 0
        
        var i: Int = 0
        
        (0..<hotspotCount).map({ index in
            return self.dataSource!.hotspotViewForIndex(index, inStandMapHotspotLayerView: self)
        }).forEach({ hotspotView, stackView in
            
            hotspotViews.hotspotView.append(hotspotView)
            hotspotViews.stackView.append(stackView)
            
            hotspotView.userInteractionEnabled = true
            hotspotView.tag = i
            let gesture = UITapGestureRecognizer(target: self, action: #selector(self.hotspotWasPressed(_:)))
            hotspotView.addGestureRecognizer(gesture)
            
            self.addSubview(hotspotView)
            self.addSubview(stackView)
            
            i += 1
        })
        
        addLine()
    }
    
    func hotspotWasPressed(sender: UITapGestureRecognizer) {
        let index = sender.view!.tag
        let hotspot = hotspotViews.hotspotView[index]
        let textLabel = hotspotViews.stackView[index].arrangedSubviews.first as? UILabel
        
        hotspot.image = UIImage(named: "RedHotspotImage")
        textLabel?.textColor = UIColor(red: 158/255, green: 27/255, blue: 50/255, alpha: 1)
    

        //go to hotspot url: StandMapView.hotspots[index].url
    }

    func addLine() {
        let path = UIBezierPath()
        let shapeLayer = CAShapeLayer()
        for index in 0..<self.dataSource!.numberOfHotspots(self) {
            let stackView = hotspotViews.stackView[index]
            let hotspotView = hotspotViews.hotspotView[index]
            if stackView.frame.origin.y < 100 {
                let stackViewPoint = CGPointMake(stackView.frame.origin.x + stackView.frame.size.width / 2, stackView.frame.origin.y + stackView.frame.size.height)
                let imageViewPoint = CGPointMake((hotspotView.frame.origin.x + hotspotView.frame.size.width / 2), hotspotView.frame.origin.y)
                path.moveToPoint(stackViewPoint)
                path.addLineToPoint(imageViewPoint)
            } else {
                let stackViewPoint = CGPointMake(stackView.frame.origin.x + stackView.frame.size.width / 2, stackView.frame.origin.y)
                let imageViewPoint = CGPointMake((hotspotView.frame.origin.x + hotspotView.frame.size.width / 2), hotspotView.frame.origin.y + hotspotView.bounds.size.height)
                path.moveToPoint(stackViewPoint)
                path.addLineToPoint(imageViewPoint)
            }
            shapeLayer.path = path.CGPath
            shapeLayer.strokeColor = UIColor.whiteColor().CGColor
            shapeLayer.lineWidth = 0.2
            shapeLayer.fillColor = UIColor.whiteColor().CGColor
            self.layer.addSublayer(shapeLayer)
        }
    }
    
    func reloadData() {
        self.setNeedsLayout()
    }
}

