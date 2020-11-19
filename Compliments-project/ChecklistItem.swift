//
//  ChecklistItem.swift
//  Compliments-project
//
//  Created by MacBook Pro on 14.11.20.
//

import Foundation
import UserNotifications
class ChecklistItem {
    let itemName: String
    var isChecked: Bool
    var shouldRemind: Bool
    var dueDate: Date = Date()
    var itemID = -1
    init(_ itemName: String, isChecked: Bool, shouldRemind: Bool) {
    self.itemName = itemName
    self.isChecked = isChecked
    self.shouldRemind = shouldRemind
   }
//    func schedulNotification() {
//
//    }
    // MARK: - How to make a local notification?
    private func removedNotification() {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: ["\(itemID)"])
    }
}
//localNotification
//class func nextChecklistItem() -> Int {
//    let userDefaults = UserDefaults.standard
//    let itemID = userDefaults.integer(forKey: "ChecklistItemID")
//    userDefaults.set(itemID + 1,forKey: "ChecklistItemID")
//    userDefaults.synchronize()
//    return itemID
//}
