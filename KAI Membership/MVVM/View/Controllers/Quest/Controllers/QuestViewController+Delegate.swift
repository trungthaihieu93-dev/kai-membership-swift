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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView, didUpdate: NestedScrollViewController.ScrollType) {
//        switch didUpdate {
//        case .parent:
//
//        case .child:
//
//        }
        
        let y: CGFloat = scrollView.contentOffset.y
        
        if y <= 0 {
//            headerView.frame.size.height = 300 + y
//            navigationBarAnimation(withAlpha: 0)
            headerView.zoomImage(with: y)
        } else {
//            let headerHeight: CGFloat = headerView.originalHeaderHeight
//            let tmp = y / headerHeight
//            let alpha = y > headerHeight || tmp >= 1 ? 1 : tmp
//            navigationBarAnimation(withAlpha: alpha)
        }
    }
    
//    func tp_scrollView(_ scrollView: UIScrollView, didUpdate progress: CGFloat) {
//        let y: CGFloat = scrollView.contentOffset.y
//        let headerHeight: CGFloat = PostCollectionHeaderNode.height - Constants.Values.NavigationHeight
//
//        if y <= 0 {
//            navigationAlpha = 0
//            detailHeaderNode.view.snp.updateConstraints {
//                $0.height.equalTo(PostCollectionHeaderNode.height - y)
//            }
//            detailHeaderNode.zoomImage(with: -y)
//            isStatusBarDefault = false
//        } else {
//            let alpha = y / headerHeight
//            navigationAlpha = scrollView.contentOffset.y > headerHeight || alpha >= 1 ? 1 : alpha
//            isStatusBarDefault = true
//        }
//    }
    
    func scrollViewDidLoad(_ scrollView: UIScrollView) {
//        refresh.tintColor = .black
//        refresh.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
//        let refreshView = UIView(frame: CGRect(x: 0, y: Constants.Values.NavigationHeight, width: 0, height: 0))
//        scrollView.addSubview(refreshView)
//        refreshView.addSubview(refresh)
//        self.scrollView = scrollView
    }
}
