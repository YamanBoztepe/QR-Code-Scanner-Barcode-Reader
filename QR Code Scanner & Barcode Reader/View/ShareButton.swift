//
//  ShareButton.swift
//  QR Code Scanner & Barcode Reader
//
//  Created by Yaman Boztepe on 8.02.2021.
//

import UIKit

class ShareButton: UIButton {
    
    let shareImage: UIImage = {
        let img = UIImage(named: "share")?.withRenderingMode(.alwaysOriginal)
        return img ?? UIImage()
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setImage(shareImage, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
