//
//  Date+Extension.swift
//  
//
//  Created by Mayank Jain on 03/01/22.
//

import Foundation

extension Date {

    /// convert into local format and return string
    ///
    /// - Parameter dateFormat: format
    /// - Returns: string in required format
    func toLocalStringWithFormat(dateFormat: String) -> String {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = NSTimeZone.local
        let timeStamp = dateFormatter.string(from: self)
        return timeStamp
    }

}
