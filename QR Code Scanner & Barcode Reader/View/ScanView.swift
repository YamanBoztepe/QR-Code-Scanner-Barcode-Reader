//
//  ScanView.swift
//  QR Code Scanner & Barcode Reader
//
//  Created by Yaman Boztepe on 11.02.2021.
//

import UIKit

class ScanView: UIView {
    
    let scanImage = UIImageView(image: UIImage(named: "scanningLine")?.withRenderingMode(.alwaysOriginal))
    let topBlurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    let bottomBlurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setLayout()
    }
    fileprivate func setLayout() {
        [scanImage,topBlurEffectView,bottomBlurEffectView].forEach(addSubview(_:))
        
        _ = scanImage.anchor(top: nil, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor)
        scanImage.positionInSuperView(size: .init(width: 0, height: frame.height/1.7), centerX: nil, centerY: centerYAnchor)
        
        topBlurEffectView.alpha = 0.4
        bottomBlurEffectView.alpha = 0.4
        
        _ = topBlurEffectView.anchor(top: topAnchor, bottom: scanImage.topAnchor, leading: leadingAnchor, trailing: trailingAnchor)
        _ = bottomBlurEffectView.anchor(top: scanImage.bottomAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor)
    }
    
    
}
