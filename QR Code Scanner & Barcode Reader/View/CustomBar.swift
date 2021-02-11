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
        btn.setImage(UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }()
    
    let shareButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "share")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    fileprivate func setLayout() {
        
        backgroundColor = .gray
        [backButton,shareButton].forEach(addSubview(_:))
        
        _ = backButton.anchor(top: nil, bottom: nil, leading: leadingAnchor, trailing: nil,padding: .init(top: 0, left: 5, bottom: 0, right: 0))
        _ = shareButton.anchor(top: nil, bottom: nil, leading: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: -5))
        
        shareButton.positionInSuperView(centerX: nil, centerY: centerYAnchor)
        backButton.positionInSuperView(centerX: nil, centerY: centerYAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
