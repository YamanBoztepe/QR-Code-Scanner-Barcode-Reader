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
    let leadingBlurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    let trailingBlurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setLayout()
    }
    fileprivate func setLayout() {
        
        let scanImageHeight = frame.height/2
        
        [scanImage,topBlurEffectView,bottomBlurEffectView,leadingBlurEffectView,trailingBlurEffectView].forEach(addSubview(_:))
        
        _ = scanImage.anchor(top: nil, bottom: nil, leading: leadingBlurEffectView.trailingAnchor, trailing: trailingBlurEffectView.leadingAnchor)
        scanImage.positionInSuperView(size: .init(width: 0, height: scanImageHeight), centerX: nil, centerY: centerYAnchor)
        
        [topBlurEffectView, bottomBlurEffectView, leadingBlurEffectView, trailingBlurEffectView].forEach { $0.alpha = 0.4 }
        
        _ = topBlurEffectView.anchor(top: topAnchor, bottom: scanImage.topAnchor, leading: leadingAnchor, trailing: trailingAnchor)
        _ = bottomBlurEffectView.anchor(top: scanImage.bottomAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor)
        
        _ = leadingBlurEffectView.anchor(top: nil, bottom: nil, leading: leadingAnchor, trailing: nil,size: .init(width: 30, height: scanImageHeight))
        leadingBlurEffectView.positionInSuperView(centerX: nil, centerY: centerYAnchor)
        
        _ = trailingBlurEffectView.anchor(top: nil, bottom: nil, leading: nil, trailing: trailingAnchor,size: .init(width: 30, height: scanImageHeight))
        trailingBlurEffectView.positionInSuperView(centerX: nil, centerY: centerYAnchor)
        
    }
    
    
}
