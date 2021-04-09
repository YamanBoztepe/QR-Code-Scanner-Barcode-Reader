//
//  QRGeneratorController.swift
//  QR Code Scanner & Barcode Reader
//
//  Created by Yaman Boztepe on 8.04.2021.
//

import UIKit

class QRGeneratorController: UIViewController {

    let qrGeneratorView = QRGeneratorView()
    var data = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    @objc fileprivate func generatorButtonPressed() {
        generateQRCode(from: data)
    }
    
    @objc fileprivate func generationCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        
        let alert = UIAlertController(title: "Completed", message: "QR Code is saved in your album", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc fileprivate func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }

}

extension QRGeneratorController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField.text?.count ?? 0 > 0 {
            qrGeneratorView.btnGenerate.isEnabled = true
            qrGeneratorView.btnGenerate.layer.borderColor = UIColor.green.cgColor
            qrGeneratorView.btnGenerate.setTitleColor(.green, for: .normal)
            data = textField.text!
        } else {
            qrGeneratorView.btnGenerate.isEnabled = false
            qrGeneratorView.btnGenerate.layer.borderColor = UIColor.red.cgColor
            qrGeneratorView.btnGenerate.setTitleColor(.red, for: .normal)
            data = "empty"
        }
    }
}
