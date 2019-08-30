//
//  ScratchMask.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/8/29.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import UIKit

class ScratchMask: UIImageView {
    
    weak var delegate: ScratchCardDelegate?
    
    var lineType:CGLineCap!
    var lineWidth: CGFloat!
    var lastPoint: CGPoint?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard  let touch = touches.first else {
            return
        }
        lastPoint = touch.location(in: self)
        
        delegate?.scratchBegan?(point: lastPoint!)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard  let touch = touches.first, let point = lastPoint, let img = image else {
            return
        }
        
        let newPoint = touch.location(in: self)
        eraseMask(fromPoint: point, toPoint: newPoint)
        lastPoint = newPoint
        
        let progress = getAlphaPixelPercent(img: img)
        delegate?.scratchMoved?(progress: progress)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard  touches.first != nil else {
            return
        }
        
        delegate?.scratchEnded?(point: lastPoint!)
    }
    
    func eraseMask(fromPoint: CGPoint, toPoint: CGPoint) {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, UIScreen.main.scale)
        
        image?.draw(in: self.bounds)
        
        let path = CGMutablePath()
        path.move(to: fromPoint)
        path.addLine(to: toPoint)
        
        let context = UIGraphicsGetCurrentContext()!
        context.setShouldAntialias(true)
        context.setLineCap(lineType)
        context.setLineWidth(lineWidth)
        context.setBlendMode(.clear)
        context.addPath(path)
        context.strokePath()
        
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    private func getAlphaPixelPercent(img: UIImage) -> Float {
        let width = Int(img.size.width)
        let height = Int(img.size.height)
        let bitmapByteCount = width * height
        
        let pixelData = UnsafeMutablePointer<UInt8>.allocate(capacity: bitmapByteCount)
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let context = CGContext(data: pixelData,
                                width: width,
                                height: height,
                                bitsPerComponent: 8,
                                bytesPerRow: width,
                                space: colorSpace,
                                bitmapInfo: CGBitmapInfo(rawValue:
                                    CGImageAlphaInfo.alphaOnly.rawValue).rawValue)!
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        context.clear(rect)
        context.draw(img.cgImage!, in: rect)
        
        var alphaPixelCount = 0
        for x in 0...Int(width) {
            for y in 0...Int(height) {
                if pixelData[y * width + x] == 0 {
                    alphaPixelCount += 1
                }
            }
        }
        
        free(pixelData)
        
        return Float(alphaPixelCount) / Float(bitmapByteCount)
    }
}
