//
//  BarEntry.swift
//  BarChart
//
//  Created by Nguyen Vu Nhat Minh on 16/8/17.
//  Copyright © 2017 Nguyen Vu Nhat Minh. All rights reserved.
//

import Foundation
import UIKit

struct DataEntry {
    let color: UIColor
    
    /// Ranged from 0.0 to 1.0
    let height: Float
    
    /// To be shown on top of the bar
    let textValue: String
    
    /// To be shown at the bottom of the bar
    let title: String
}
