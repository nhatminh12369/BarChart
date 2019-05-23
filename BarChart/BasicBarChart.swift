//
//  BasicBarChart.swift
//  BarChart
//
//  Created by Nguyen Vu Nhat Minh on 19/8/17.
//  Copyright © 2017 Nguyen Vu Nhat Minh. All rights reserved.
//

import UIKit

class BasicBarChart: UIView {
    /// contain all layers of the chart
    private let mainLayer: CALayer = CALayer()
    
    /// contain mainLayer to support scrolling
    private let scrollView: UIScrollView = UIScrollView()
    
    private var animated = false
    
    private let presenter = BasicBarChartPresenter(barWidth: 40, space: 20)
    
    private var barEntries: [BasicBarEntry] = [] {
        didSet {
            mainLayer.sublayers?.forEach({$0.removeFromSuperlayer()})
            
            scrollView.contentSize = CGSize(width: presenter.computeContentWidth(), height: self.frame.size.height)
            mainLayer.frame = CGRect(x: 0, y: 0, width: scrollView.contentSize.width, height: scrollView.contentSize.height)
            
            drawHorizontalLines()
            
            for i in 0..<barEntries.count {
                showEntry(index: i, entry: barEntries[i], animated: animated, oldEntry: (i < oldValue.count ? oldValue[i] : nil))
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
    
    private func setupView() {
        scrollView.layer.addSublayer(mainLayer)
        self.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    override func layoutSubviews() {
        self.updateDataEntries(dataEntries: presenter.dataEntries, animated: false)
    }
    
    private func showEntry(index: Int, entry: BasicBarEntry, animated: Bool, oldEntry: BasicBarEntry?) {
        
        let cgColor = entry.data.color.cgColor
        
        // Show the main bar
        mainLayer.addRectangleLayer(frame: entry.barFrame, color: cgColor, animated: animated, oldFrame: oldEntry?.barFrame)

        // Show an Int value above the bar
        mainLayer.addTextLayer(frame: entry.textValueFrame, color: cgColor, fontSize: 14, text: entry.data.textValue, animated: animated, oldFrame: oldEntry?.textValueFrame)

        // Show a title below the bar
        mainLayer.addTextLayer(frame: entry.bottomTitleFrame, color: cgColor, fontSize: 14, text: entry.data.title, animated: animated, oldFrame: oldEntry?.bottomTitleFrame)
    }
    
    private func drawHorizontalLines() {
        self.layer.sublayers?.forEach({
            if $0 is CAShapeLayer {
                $0.removeFromSuperlayer()
            }
        })
        let lines = presenter.computeHorizontalLines(viewHeight: self.frame.height)
        lines.forEach { (line) in
            mainLayer.addLineLayer(lineSegment: line.segment, color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor, width: line.width, isDashed: line.isDashed, animated: false, oldSegment: nil)
        }
    }    
}
