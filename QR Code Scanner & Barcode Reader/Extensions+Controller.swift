//
//  Extensions+Controller.swift
//  QR Code Scanner & Barcode Reader
//
//  Created by Yaman Boztepe on 21.02.2021.
//

import UIKit
import GoogleMobileAds

let interstitialAD_ID = "ca-app-pub-6297661538267039/1967949296"
var interstitial: GADInterstitialAd?

extension UIViewController {
    
    
    func presentOutput(stringValue: String) {
        
        presentAds()
        
        if let url = URL(string: stringValue) {
            if UIApplication.shared.canOpenURL(url) {
                let vc = WebController()
                vc.url = url
                navigationController?.pushViewController(vc, animated: true)
                return
            }
        }
        
        presentText(stringValue: stringValue)
    }
    
    fileprivate func presentText(stringValue: String) {
        let vc = OutputTextController()
        vc.outputText = stringValue
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func requestAds() {
        
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID: interstitialAD_ID, request: request) { (ad, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let ads = ad else { return }
            interstitial = ads
        }
    }
    
    func presentAds() {
        
        if interstitial != nil {
            interstitial!.present(fromRootViewController: self)
        } else {
            print("ads wasnt ready")
        }
    }
}

