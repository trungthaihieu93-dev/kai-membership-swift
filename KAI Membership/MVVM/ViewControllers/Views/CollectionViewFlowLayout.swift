//
//  CollectionViewFlowLayout.swift
//  KAI Membership
//
//  Created by DAKiet on 26/03/2021.
//

import UIKit

class HorizontalPagingCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = self.collectionView else { return .zero }
        
        var offsetAdjustment: CGFloat = CGFloat.infinity
        let horizontalOffset: CGFloat = proposedContentOffset.x + sectionInset.left

        let targetRect: CGRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)

        guard let layoutAttributes = super.layoutAttributesForElements(in: targetRect) else { return .zero }

            for item in layoutAttributes {
                let itemOffset: CGFloat = item.frame.origin.x
                
                if abs(itemOffset - horizontalOffset) < abs(offsetAdjustment) {
                    offsetAdjustment = itemOffset - horizontalOffset
                }
            }

        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }
}
