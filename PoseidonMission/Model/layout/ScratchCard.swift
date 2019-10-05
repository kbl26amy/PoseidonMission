//
//  ScratchCard.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/8/29.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import UIKit

@objc protocol ScratchCardDelegate {
    @objc optional func scratchBegan(point: CGPoint)
    @objc optional func scratchMoved(progress: Float)
    @objc optional func scratchEnded(point: CGPoint)
}

class ScratchCard: UIView {
    var scratchMask: ScratchMask!
    var mapImageView: UIImageView!
    
    weak var delegate: ScratchCardDelegate?
        {
        didSet
        {
            scratchMask.delegate = delegate
        }
    }
    
    public init(frame: CGRect, mapImage: UIImage, maskImage: UIImage,
                scratchWidth: CGFloat = 15, scratchType: CGLineCap = .square) {
        super.init(frame: frame)
        
        let childFrame = CGRect(x: 0, y: 0, width: self.frame.width,
                                height: self.frame.height)
        
        mapImageView = UIImageView(frame: childFrame)
        mapImageView.image = mapImage
        self.addSubview(mapImageView)
        
        scratchMask = ScratchMask(frame: childFrame)
        scratchMask.image = maskImage
        scratchMask.lineWidth = scratchWidth
        scratchMask.lineType = scratchType
        self.addSubview(scratchMask)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
