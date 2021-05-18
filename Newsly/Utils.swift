//
//  Utils.swift
//  Newsly
//
//  Created by Kislay Kishore on 07/05/21.
//

import Foundation


class Utils {
    
    class func isoToSinceTime(isoTime: String?) -> String {
        guard let iso = isoTime else {
            return NSLocalizedString("NA", comment: "")
        }
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.ISO_DATE_FORMAT
        guard let date = formatter.date(from: iso) else {
            return NSLocalizedString("NA", comment: "")
        }
        let currentTime = NSDate.now.timeIntervalSince1970
        let timeDiff = currentTime - date.timeIntervalSince1970
        let mins = timeDiff / (60)
        if mins < 1 {
            return NSLocalizedString("JustNow", comment: "")
        } else if mins < 60 {
            return String(format: NSLocalizedString("%@ mins-ago", comment: ""), String(Int(mins)))
        }
        let hours = mins / 60
        if hours < 24 {
            return String(format: NSLocalizedString("%@ hours-ago", comment: ""), String(Int(hours)))
        }
        let days = hours / 24
        return String(format: NSLocalizedString("%@ days-ago", comment: ""), String(Int(days)))
    }
        
}
