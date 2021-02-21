//
//  Extensions+NSDate.swift
//  QR Code Scanner & Barcode Reader
//
//  Created by Yaman Boztepe on 20.02.2021.
//

import UIKit

extension Date {
    
    func getDate() -> String {
        
        let currentCalendar = Calendar.current
        
        let day = currentCalendar.component(.day, from: self)
        let month = currentCalendar.component(.month, from: self)
        let year = currentCalendar.component(.year, from: self)
        
        return "\(day)/\(month)/\(year)"
    }
}
