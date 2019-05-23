//
//  BeautifulBarEntry.swift
//  BarChart
//
//  Created by Nguyen Vu Nhat Minh on 22/5/19.
//  Copyright © 2019 Nguyen Vu Nhat Minh. All rights reserved.
//

import Foundation
import CoreGraphics.CGGeometry

struct BeautifulBarEntry {
    let position: CGPoint // Bottom-left position of the item
    let barWidth: CGFloat
    let barHeight: CGFloat
    let data: DataEntry
    let mainBarEntry: MainBarEntry
    let topBubbleEntry: TopBubbleEntry
    
    init(origin: CGPoint, barWidth: CGFloat, barHeight: CGFloat, data: DataEntry) {
        self.position = origin
        self.barWidth = barWidth
        self.barHeight = barHeight
        self.data = data
        self.mainBarEntry = MainBarEntry(position: self.position, barWidth: barWidth, barHeight: barHeight)
        self.topBubbleEntry = TopBubbleEntry(barBottomLeftPoint: self.position, barWidth: barWidth, barHeight: barHeight)
    }
    
    var bottomTitleFrame: CGRect {
        return CGRect(x: position.x, y: position.y + barHeight + 10, width: barWidth, height: 22)
    }
    
    var linkingLine: LineSegment {
        let startPoint = CGPoint(x: position.x + barWidth / 2, y: position.y - 4)
        let endPoint = CGPoint(x: startPoint.x, y: startPoint.y - 40)
        return LineSegment(startPoint: startPoint, endPoint: endPoint)
    }
}

struct MainBarEntry {
    let position: CGPoint
    let barWidth: CGFloat
    let barHeight: CGFloat
    init(position: CGPoint, barWidth: CGFloat, barHeight: CGFloat) {
        self.position = position
        self.barWidth = barWidth
        self.barHeight = barHeight
    }
    
    var curvedSegments: [CurvedSegment] {
        var startPoint, endPoint, toPoint, controlPoint1, controlPoint2: CGPoint
        
        startPoint = CGPoint(x: position.x, y: position.y + barHeight)
        endPoint = CGPoint(x: position.x + barWidth/2, y: position.y + barHeight)
        toPoint = CGPoint(x: position.x + barWidth/2, y: position.y)
        controlPoint1 = CGPoint(x: (position.x + barWidth/2), y: position.y + barHeight)
        controlPoint2 = CGPoint(x: position.x + barWidth*3/10, y: position.y)
        let segment1 = CurvedSegment(startPoint: startPoint, endPoint: endPoint, toPoint: toPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        
        startPoint = CGPoint(x: position.x + barWidth, y: position.y + barHeight)
        endPoint = CGPoint(x: position.x + barWidth/2, y: position.y + barHeight)
        toPoint = CGPoint(x: position.x + barWidth/2, y: position.y)
        controlPoint1 = CGPoint(x: position.x+barWidth/2, y: position.y + barHeight)
        controlPoint2 = CGPoint(x: position.x + barWidth*7/10, y: position.y)
        let segment2 = CurvedSegment(startPoint: startPoint, endPoint: endPoint, toPoint: toPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        
        return [segment1, segment2]
    }
}

struct TopBubbleEntry {
    private let topBubbleRadius: CGFloat = 20.0
    private var curvedValue: CGFloat {
        /// This curveValue helps to create 2 control points that can be used to draw a quater of a circle using Bezier curve function
        return 0.552284749831 * topBubbleRadius
    }
    
    let position: CGPoint
    var textValueFrame: CGRect {
        return CGRect(x: position.x, y: position.y - 6, width: topBubbleRadius * 2, height: 22)
    }
    
    init(barBottomLeftPoint point: CGPoint, barWidth: CGFloat, barHeight: CGFloat) {
        self.position = CGPoint(x: point.x + barWidth / 2 - topBubbleRadius, y: round(point.y - barHeight - 80))
    }
    
    var curvedSegments: [CurvedSegment] {
        var startPoint, endPoint, toPoint, controlPoint1, controlPoint2: CGPoint
        
        startPoint = position
        endPoint = CGPoint(x: position.x + topBubbleRadius, y: position.y)
        toPoint = CGPoint(x: position.x + topBubbleRadius, y: position.y - topBubbleRadius)
        controlPoint1 = CGPoint(x: position.x, y: position.y - curvedValue)
        controlPoint2 = CGPoint(x: position.x + topBubbleRadius - curvedValue, y: position.y - topBubbleRadius)
        let segment1 = CurvedSegment(startPoint: startPoint, endPoint: endPoint, toPoint: toPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        
        startPoint = CGPoint(x: position.x + topBubbleRadius, y: position.y - topBubbleRadius)
        endPoint = CGPoint(x: position.x + topBubbleRadius, y: position.y)
        toPoint = CGPoint(x: position.x + topBubbleRadius*2, y: position.y)
        controlPoint1 = CGPoint(x: position.x + topBubbleRadius + curvedValue, y: position.y - topBubbleRadius)
        controlPoint2 = CGPoint(x: position.x + topBubbleRadius * 2, y: position.y - curvedValue)
        let segment2 = CurvedSegment(startPoint: startPoint, endPoint: endPoint, toPoint: toPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        
        startPoint = position
        endPoint = CGPoint(x: position.x + topBubbleRadius, y: position.y)
        toPoint = CGPoint(x: position.x + topBubbleRadius, y: position.y + topBubbleRadius*1.5)
        controlPoint1 = CGPoint(x: position.x, y: position.y + curvedValue)
        controlPoint2 = CGPoint(x: position.x + topBubbleRadius - curvedValue, y: position.y + topBubbleRadius)
        let segment3 = CurvedSegment(startPoint: startPoint, endPoint: endPoint, toPoint: toPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        
        startPoint = CGPoint(x: position.x + topBubbleRadius*2, y: position.y)
        endPoint = CGPoint(x: position.x + topBubbleRadius, y: position.y)
        toPoint = CGPoint(x: position.x + topBubbleRadius, y: position.y + topBubbleRadius * 1.5)
        controlPoint1 = CGPoint(x: position.x + topBubbleRadius * 2, y: position.y + curvedValue)
        controlPoint2 = CGPoint(x: position.x + topBubbleRadius + curvedValue, y: position.y + topBubbleRadius)
        let segment4 = CurvedSegment(startPoint: startPoint, endPoint: endPoint, toPoint: toPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        
        return [segment1, segment2, segment3, segment4]
    }
}
