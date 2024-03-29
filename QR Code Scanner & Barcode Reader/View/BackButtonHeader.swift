//
//  HeaderOfHC.swift
//  QR Code Scanner & Barcode Reader
//
//  Created by Yaman Boztepe on 15.02.2021.
//

import UIKit


class BackButtonHeader: CustomBar {
    
    let lblTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "History"
        lbl.textAlignment = .center
        lbl.textColor = .white
        return lbl
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setLayout()
    }
    
    fileprivate func setLayout() {
        
        backgroundColor = UIColor.rgb(red: 23, green: 23, blue: 23)
        shareButton.isHidden = true
        addSubview(lblTitle)
        
        _ = lblTitle.anchor(top: nil, bottom: nil, leading: nil, trailing: nil,size: .init(width: frame.width/3, height: frame.width/8))
        lblTitle.positionInSuperView(centerX: centerXAnchor, centerY: centerYAnchor)
        lblTitle.font = UIFont.boldSystemFont(ofSize: frame.width/16)
        
    }
    
}
