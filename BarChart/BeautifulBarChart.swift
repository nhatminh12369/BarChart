//
//  BeautifulBarChartView.swift
//  BarChart
//
//  Created by Nguyen Vu Nhat Minh on 16/8/17.
//  Copyright © 2017 Nguyen Vu Nhat Minh. All rights reserved.
//

import UIKit

class BeautifulBarChart: UIView {
    private let mainLayer: CALayer = CALayer()
    private let scrollView: UIScrollView = UIScrollView()
    
    private let presenter = BeautifulBarChartPresenter(barWidth: 140, space: -70)
    
    private var animated: Bool = false
    
    private var barEntries: [BeautifulBarEntry] = [] {
        didSet {
            mainLayer.sublayers?.forEach({$0.removeFromSuperlayer()})
            
            scrollView.contentSize = CGSize(width: presenter.computeContentWidth(), height: self.frame.size.height)
            mainLayer.frame = CGRect(x: 0, y: 0, width: scrollView.contentSize.width, height: scrollView.contentSize.height)
            
            for (index, entry) in barEntries.enumerated() {
                showEntry(index: index, barEntry: entry, animated: animated, oldEntry: oldValue.safeValue(at: index))
            }
        }
    }
    
    func updateDataEntries(dataEntries: [DataEntry], animated: Bool) {
        self.animated = animated
        self.presenter.dataEntries = dataEntries
        self.barEntries = self.presenter.computeBarEntries(viewHeight: self.frame.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.updateDataEntries(dataEntries: presenter.dataEntries, animated: false)
    }
    
    private func setupView() {
        scrollView.layer.addSublayer(mainLayer)
        self.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func showEntry(index: Int, barEntry: BeautifulBarEntry, animated: Bool, oldEntry: BeautifulBarEntry?) {
        let cgColor = barEntry.data.color.cgColor
        
        // Create the curved bar for an entry
        for (index, entry) in barEntry.mainBarEntry.curvedSegments.enumerated() {
            let oldSegment = oldEntry?.mainBarEntry.curvedSegments[index]
            mainLayer.addCurvedLayer(curvedSegment: entry, color: cgColor, animated: animated, oldSegment: oldSegment)
        }
        
        /// Create the top bubble
        for (index, entry) in barEntry.topBubbleEntry.curvedSegments.enumerated() {
            let oldSegment = oldEntry?.topBubbleEntry.curvedSegments[index]
            mainLayer.addCurvedLayer(curvedSegment: entry, color: cgColor, animated: animated, oldSegment: oldSegment)
        }
        
        /// Create the text above the bar, inside the top bubble
        mainLayer.addTextLayer(frame: barEntry.topBubbleEntry.textValueFrame, color: UIColor.white.cgColor, fontSize: 14, text: barEntry.data.textValue, animated: animated, oldFrame: oldEntry?.topBubbleEntry.textValueFrame)
        
        /// Create the line that connect top of the bar to the top bubble
        mainLayer.addLineLayer(lineSegment: barEntry.linkingLine, color: cgColor, width: 2.0, isDashed: false, animated: animated, oldSegment: oldEntry?.linkingLine)
        /// Create a small circle at the top of the linking line
        let radius: CGFloat = 3.0
        var oldPosition: CGPoint? = nil
        if let oldEntry = oldEntry {
            oldPosition = CGPoint(x: oldEntry.linkingLine.endPoint.x - radius, y: oldEntry.linkingLine.endPoint.y)
        }
        mainLayer.addCircleLayer(origin: CGPoint(x: barEntry.linkingLine.endPoint.x - radius, y: barEntry.linkingLine.endPoint.y) , radius: radius, color: cgColor, animated: animated, oldOrigin: oldPosition)
        
        /// Create text below the bar
        mainLayer.addTextLayer(frame: barEntry.bottomTitleFrame, color: cgColor, fontSize: 14, text: barEntry.data.title, animated: animated, oldFrame: oldEntry?.bottomTitleFrame)
    }
}
