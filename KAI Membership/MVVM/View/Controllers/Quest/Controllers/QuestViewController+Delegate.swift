//
//  QuestViewController+Delegate.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 05/03/2021.
//

import UIKit

// MARK: NestedScrollDelegate
extension QuestViewController: NestedScrollDelegate {
    
    func selectedIndexChanged(for pagerTabPageController: NestedScrollViewController, previousIndex: Int, currentIndex: Int) {
        headerView.segmentView.selectedSegmentIndex = currentIndex
    }
}
