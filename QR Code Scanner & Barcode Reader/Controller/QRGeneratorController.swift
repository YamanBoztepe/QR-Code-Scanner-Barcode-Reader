//
//  QRGeneratorController.swift
//  QR Code Scanner & Barcode Reader
//
//  Created by Yaman Boztepe on 8.04.2021.
//

import UIKit
import GoogleMobileAds

class QRGeneratorController: UIViewController {

    let qrGeneratorView = QRGeneratorView()
    var data = ""
    var imageSaved: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestAds()
        qrGeneratorView.txtData.delegate = self
        setLayout()
    }
    
    
    fileprivate func setLayout() {
        
        view.backgroundColor = UIColor.rgb(red: 23, green: 23, blue: 23)
        
        navigationController?.navigationBar.isHidden = true
        view.addSubview(qrGeneratorView)
        
        _ = qrGeneratorView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        qrGeneratorView.btnGenerate.addTarget(self, action: #selector(generatorButtonPressed), for: .touchUpInside)
        qrGeneratorView.header.backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }

    
    fileprivate func generateQRCode(from string: String) {
        
        presentAds()
        interstitial?.fullScreenContentDelegate = self
        
        let data = string.data(using: .ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 100, y: 100)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                let cgImage = CIContext().createCGImage(output, from: output.extent)
                let qrCodeImage = UIImage(cgImage: cgImage!)
                UIImageWriteToSavedPhotosAlbum(qrCodeImage, self, #selector(generationCompleted), nil)
            }
        }
    }
    
    fileprivate func presentImageSavedAlert() {
        let alert = UIAlertController(title: "Completed", message: "QR Code is saved in your album", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc fileprivate func generatorButtonPressed() {
        generateQRCode(from: data)
    }
    
    @objc fileprivate func generationCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        
        imageSaved = true
        
        if interstitial == nil {
            presentImageSavedAlert()
        }
    }
    
    @objc fileprivate func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }

}

extension QRGeneratorController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField.text?.count ?? 0 > 0 {
            qrGeneratorView.btnGenerate.isEnabled = true
            qrGeneratorView.btnGenerate.layer.borderColor = UIColor.rgb(red: 0, green: 128, blue: 0).cgColor
            qrGeneratorView.btnGenerate.setTitleColor(UIColor.rgb(red: 0, green: 128, blue: 0), for: .normal)
            data = textField.text!
        } else {
            qrGeneratorView.btnGenerate.isEnabled = false
            qrGeneratorView.btnGenerate.layer.borderColor = UIColor.gray.withAlphaComponent(0.3).cgColor
            qrGeneratorView.btnGenerate.setTitleColor(UIColor.gray.withAlphaComponent(0.3), for: .normal)
            data = "empty"
        }
    }
}

extension QRGeneratorController: GADFullScreenContentDelegate {
    
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        presentImageSavedAlert()
      }

      /// Tells the delegate that the ad presented full screen content.
      func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did present full screen content.")
      }

      /// Tells the delegate that the ad dismissed full screen content.
      func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        
        if imageSaved {
            presentImageSavedAlert()
        }
      }
}
