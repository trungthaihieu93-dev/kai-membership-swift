//
//  DailyQuestViewController+Delegate.swift
//  KAI Membership
//
//  Created by DAKiet on 31/03/2021.
//

import UIKit

// MARK: UITableViewDelegate
extension DailyQuestViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard quests.count > 0, quests[indexPath.row].key == .inviteFriend else { return }
        
        didFinishTouchingInviteFriend?()
    }
}
