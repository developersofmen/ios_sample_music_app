//
//  String+Extension.swift
//  
//
//  Created by Mayank Jain on 03/01/22.
//

import Foundation

extension String {
    
    public func getDate (_ thisFormat:String) -> Date
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = thisFormat
        dateFormatter.timeZone = TimeZone.init(identifier: "UTC")
        if let  date = dateFormatter.date(from: self) as NSDate? {
            return date as Date
          
        } else {
            return Date()
        }
    }

}
