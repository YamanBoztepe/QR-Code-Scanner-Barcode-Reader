//
//  OutputTextController.swift
//  QR Code Scanner & Barcode Reader
//
//  Created by Yaman Boztepe on 7.02.2021.
//

import UIKit

class OutputTextController: UIViewController {

    var outputText: String = ""
    let outputTextField = OutputTextView()
    
    let extraView = UIView()
    let customBar = CustomBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLayout()
    }
    
    fileprivate func setLayout() {
        
        extraView.backgroundColor = customBar.backgroundColor
        [outputTextField,customBar,extraView].forEach(view.addSubview(_:))
        
        _ = outputTextField.anchor(top: extraView.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        _ = extraView.anchor(top: view.topAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        _ = customBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,size: .init(width: 0, height: view.frame.height/15))
        
        customBar.shareButton.addTarget(self, action: #selector(shareButtonPressed), for: .touchUpInside)
        customBar.backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        
        outputTextField.text = outputText
    }
    
    @objc fileprivate func shareButtonPressed() {
        
        let vc = UIActivityViewController(activityItems: [outputText], applicationActivities: [])
        present(vc, animated: true)
    }
    
    @objc fileprivate func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }

}
