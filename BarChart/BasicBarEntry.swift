//
//  BasicBarEntry.swift
//  BarChart
//
//  Created by Nguyen Vu Nhat Minh on 22/5/19.
//  Copyright © 2019 Nguyen Vu Nhat Minh. All rights reserved.
//

import Foundation
import CoreGraphics.CGGeometry

struct BasicBarEntry {
    let position: CGPoint
    let barWidth: CGFloat
    let barHeight: CGFloat
    let space: CGFloat
    let data: DataEntry
    
    var bottomTitleFrame: CGRect {
        return CGRect(x: position.x - space/2, y: position.y + 10 + barHeight, width: barWidth + space, height: 22)
    }
    
    var textValueFrame: CGRect {
        return CGRect(x: position.x - space/2, y: position.y - 30, width: barWidth + space, height: 22)
    }
    
    var barFrame: CGRect {
        return CGRect(x: position.x, y: position.y, width: barWidth, height: barHeight)
    }
}

struct HorizontalLine {
    let segment: LineSegment
    let isDashed: Bool
    let width: CGFloat
}
