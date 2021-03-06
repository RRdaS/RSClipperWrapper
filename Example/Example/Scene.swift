//
//  Scene.swift
//  Example
//
//  Created by Matthias Fey on 10.08.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

import SpriteKit
import RSClipperWrapper

class Scene : SKScene {
    
    let polygon1 = [CGPoint(x: -50, y: -50), CGPoint(x: -50, y: 25), CGPoint(x: 25, y: 25), CGPoint(x: 25, y: -50)]
    let polygon2 = [CGPoint(x: -25, y: -25), CGPoint(x: -25, y: 50), CGPoint(x: 50, y: 50), CGPoint(x: 50, y: -25)]
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.whiteColor()
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let polygonNode1 = SKShapeNode()
        polygonNode1.strokeColor = SKColor.blackColor()
        polygonNode1.lineWidth = 1
        polygonNode1.path = CGPath.pathOfPolygons([polygon1])
        addChild(polygonNode1)
        
        let polygonNode2 = SKShapeNode()
        polygonNode2.strokeColor = SKColor.blackColor()
        polygonNode2.lineWidth = 1
        polygonNode2.path = CGPath.pathOfPolygons([polygon2])
        addChild(polygonNode2)
        
        let clipperPolygon = Clipper.intersectPolygons([polygon1], withPolygons: [polygon2])
        
        let clipperNode = SKShapeNode()
        clipperNode.lineWidth = 0
        clipperNode.fillColor = SKColor.redColor()
        clipperNode.zPosition = -1
        clipperNode.path = CGPath.pathOfPolygons(clipperPolygon)
        addChild(clipperNode)
        
        let pt = CGPointMake(0, 0)
        let inPoly = Clipper.polygonContainsPoint(clipperPolygon[0], point: pt)
        NSLog(inPoly ? "point is in poly" : "point is not in poly")
    }
}

extension CGPath {
    
    class func pathOfPolygons(polygons: [[CGPoint]]) -> CGPath {
        let path = CGPathCreateMutable()
        for polygon in polygons {
            for (index, point) in polygon.enumerate() {
                if index == 0 { CGPathMoveToPoint(path, nil, point.x, point.y) }
                else { CGPathAddLineToPoint(path, nil, point.x, point.y) }
            }
            if polygon.count > 2 { CGPathCloseSubpath(path) }
        }
        
        return path
    }
}
