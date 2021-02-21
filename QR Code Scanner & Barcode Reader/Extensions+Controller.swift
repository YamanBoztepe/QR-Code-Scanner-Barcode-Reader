//
//  Extensions+Controller.swift
//  QR Code Scanner & Barcode Reader
//
//  Created by Yaman Boztepe on 21.02.2021.
//

import UIKit

extension UIViewController {
    
    func presentOutput(stringValue: String) {
        
        if let url = URL(string: stringValue) {
            UIApplication.shared.open(url, options: [:]) { (complete) in
                if !complete {
                    self.presentText(stringValue: stringValue)
                }
            }
            return
        }
        
        presentText(stringValue: stringValue)
    }
    
    fileprivate func presentText(stringValue: String) {
        let vc = OutputTextController()
        vc.outputText = stringValue
        navigationController?.pushViewController(vc, animated: true)
    }
}

