//
//  WebBottomBar.swift
//  QR Code Scanner & Barcode Reader
//
//  Created by Yaman Boztepe on 1.05.2021.
//

import UIKit

class WebBottomBar: CustomBar {
    
    let forwardButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
        btn.setDefaultLayout(verticalAlignment: .fill, horizontalAlignment: .right, color: .white)
        return btn
    }()
    
    let safariButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "safari"), for: .normal)
        btn.setDefaultLayout(verticalAlignment: .fill, horizontalAlignment: .center, color: .white)
        return btn
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setLayout()
    }
    
    fileprivate func setLayout() {
        
        backgroundColor = UIColor.rgb(red: 38, green: 38, blue: 38)
        
        backButton.isEnabled = false
        forwardButton.isEnabled = false
        
        [forwardButton,safariButton].forEach {  addSubview($0) }
        
        _ = forwardButton.anchor(top: nil, bottom: nil, leading: backButton.trailingAnchor, trailing: nil,size: .init(width: frame.width/8, height: 0))
        forwardButton.positionInSuperView(centerX: nil, centerY: centerYAnchor)
        
        _ = safariButton.anchor(top: nil, bottom: nil, leading: nil, trailing: shareButton.leadingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: -5),size: .init(width: frame.width/10, height: 0))
        safariButton.positionInSuperView(centerX: nil, centerY: centerYAnchor)
    }
}
