//
//  CustomBar.swift
//  QR Code Scanner & Barcode Reader
//
//  Created by Yaman Boztepe on 11.02.2021.
//

import UIKit

class CustomBar: UIView {
    
    let backButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        btn.setDefaultLayout(verticalAlignment: .fill, horizontalAlignment: .left, color: .white)
        return btn
    }()
    
    let shareButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        btn.setDefaultLayout(verticalAlignment: .fill, horizontalAlignment: .center, color: .white)
        return btn
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setLayout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    fileprivate func setLayout() {
        
        backgroundColor = UIColor.rgb(red: 23, green: 23, blue: 23)
        [backButton,shareButton].forEach(addSubview(_:))
        
        _ = backButton.anchor(top: nil, bottom: nil, leading: leadingAnchor, trailing: nil,padding: .init(top: 0, left: 15, bottom: 0, right: 0),size: .init(width: frame.width/8, height: 0))
        _ = shareButton.anchor(top: nil, bottom: nil, leading: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: -15),size: .init(width: frame.width/10, height: 0))
        
        shareButton.positionInSuperView(centerX: nil, centerY: centerYAnchor)
        backButton.positionInSuperView(centerX: nil, centerY: centerYAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
