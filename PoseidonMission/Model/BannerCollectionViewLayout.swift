//
//  BannerCollectionViewLayout.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/8/28.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import Foundation
import UIKit

class FlatCardCollectionViewLayout: UICollectionViewFlowLayout {
    
    override open func prepare() {
        super.prepare()
        
        scrollDirection = .horizontal
        
        let inset = (collectionView!.frame.size.width - itemSize.width) * 0.5
        sectionInset = UIEdgeInsets(top:  0, left: inset, bottom: 0, right: inset)
        
    }
    
    override open var collectionViewContentSize: CGSize {
        if collectionView == nil { return CGSize.zero }
        
        let itemsCount = CGFloat(collectionView!.numberOfItems(inSection: 0))
        return CGSize(width: collectionView!.bounds.width * itemsCount,
                      height: collectionView!.bounds.height )
    }
    
    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        if collectionView == nil { return nil }

        // 從supser 獲取已經計算好的佈局屬性
        let attributes = super.layoutAttributesForElements(in: rect)

        let centerX = collectionView!.contentOffset.x + collectionView!.bounds.width / 2.0

        for attribute in attributes! {

            // cell 中心點 和 collectionView 中心點的間距
            let delta = Swift.abs(attribute.center.x - centerX)

            // 根據間隔距離計算縮放比例
            let scale = 1.3 - delta / collectionView!.frame.size.width

            // 設置縮放比例
            attribute.transform = CGAffineTransform(scaleX: scale, y: scale);


        }

        return attributes
    }

    override open func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}

class PageCollectionViewLayout: UICollectionViewFlowLayout {
    
    override open func prepare() {
        super.prepare()
        
        scrollDirection = .horizontal
        let inset = (collectionView!.frame.size.width - itemSize.width) * 0.5
        sectionInset = UIEdgeInsets(top:  0, left: inset, bottom: 0, right: inset)
        
    }
    
    override open var collectionViewContentSize: CGSize {
        if collectionView == nil { return CGSize.zero }
        
       var itemsCount = CGFloat()
        if collectionView?.numberOfSections == 0{
        
            if collectionView!.numberOfItems(inSection: 0) % 3 == 0 {
                itemsCount = CGFloat(collectionView!.numberOfItems(inSection: 0) / 3)
            } else {
                itemsCount = CGFloat(collectionView!.numberOfItems(inSection: 0) / 3 + 1)
            }
        } else {
            if collectionView!.numberOfItems(inSection: 0) % 3 == 0 {
                itemsCount = CGFloat(collectionView!.numberOfItems(inSection: 1) / 3)
            } else {
                itemsCount = CGFloat(collectionView!.numberOfItems(inSection: 1) / 3 + 1)
            }
        }
        
        return CGSize(width: collectionView!.bounds.width * itemsCount ,
                      height: collectionView!.bounds.height )
    }
    
    override open func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}

class BannerCollectionViewLayout: UICollectionViewFlowLayout {
    
    override open func prepare() {
        super.prepare()
        
        scrollDirection = .horizontal
        sectionInset = UIEdgeInsets(top:  0, left: 16, bottom: 0, right: 0)
        
    }
    
    override open var collectionViewContentSize: CGSize {
        if collectionView == nil { return CGSize.zero }
        
        var itemsCount = CGFloat()
        itemsCount = CGFloat(collectionView!.numberOfItems(inSection: 0) )
        
        
        return CGSize(width: collectionView!.bounds.width * itemsCount ,
                      height: collectionView!.bounds.height )
    }
    
    override open func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
