//
//  Extensions+UITextField.swift
//  QR Code Scanner & Barcode Reader
//
//  Created by Yaman Boztepe on 9.04.2021.
//

import UIKit

extension UITextField {
    
    func addDoneButtonOnKeyboard() {
        
        let doneToolbar: UIToolbar = UIToolbar(frame: .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpaceBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonPressed))
        
        let items = [flexSpaceBarButton, doneBarButton]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonPressed() {
        self.resignFirstResponder()
    }
}

extension String {
    
    func shortURL() -> String {
        
        if self.hasPrefix("www.") {
            return String(self.dropFirst(4))
        }
        return self
    }
}
