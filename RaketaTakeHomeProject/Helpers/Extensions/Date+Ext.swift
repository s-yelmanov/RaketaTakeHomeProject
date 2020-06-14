//
//  Date+Ext.swift
//  RaketaTakeHomeProject
//
//  Created by Sergey Yelmanov on 13.06.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import Foundation

extension Date {

    func timeAgoSinceDate() -> String {
        let calendar =  Calendar.current
        let fromDate = self
        let toDate = Date()

        if let interval = calendar.dateComponents([.hour], from: fromDate, to: toDate).hour,
            interval > 0 {
            return interval == 1 ? "\(interval)" + " " + "hour ago" : "\(interval)" + " " + "hours ago"
        }

        if let interval = calendar.dateComponents([.minute], from: fromDate, to: toDate).minute,
            interval > 0 {
            return interval == 1 ? "\(interval)" + " " + "minute ago" : "\(interval)" + " " + "minutes ago"
        }

        return "a moment ago"
    }

}
