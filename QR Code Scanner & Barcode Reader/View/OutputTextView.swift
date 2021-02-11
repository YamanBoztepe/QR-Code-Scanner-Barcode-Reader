//
//  OutputTextView.swift
//  QR Code Scanner & Barcode Reader
//
//  Created by Yaman Boztepe on 7.02.2021.
//

import UIKit

class OutputTextView: UITextView {

    let backgroundImage = UIImageView(image: UIImage(named: "page")?.withRenderingMode(.alwaysOriginal))
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setLayout()
    }
    
    
    fileprivate func setLayout() {
        
        addSubview(backgroundImage)
        _ = backgroundImage.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor)
        sendSubviewToBack(backgroundImage)
        
        backgroundColor = .clear
        textColor = .black
        isEditable = false
        font = UIFont.systemFont(ofSize: frame.width/20)
        textContainerInset = UIEdgeInsets(top: frame.width/4.5, left: frame.width/15, bottom: frame.width/15, right: frame.width/15)
    }
    
}

