//
//  WebBar.swift
//  QR Code Scanner & Barcode Reader
//
//  Created by Yaman Boztepe on 1.05.2021.
//

import UIKit

class WebBar: UIView {
    
    let doneButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Done", for: .normal)
        btn.titleLabel?.numberOfLines = 0
        return btn
    }()
    
    let urlField: UITextField = {
        let txt = UITextField()
        txt.backgroundColor = UIColor.rgb(red: 64, green: 64, blue: 64)
        txt.textColor = .lightGray
        txt.textAlignment = .center
        txt.layer.cornerRadius = 10
        txt.isUserInteractionEnabled = false
        return txt
    }()
    
    let refreshButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        btn.setDefaultLayout(verticalAlignment: .center, horizontalAlignment: .center, color: .white)
        return btn
    }()
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        spinner.color = .white
        return spinner
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setLayout()
    }
    
    fileprivate func setLayout() {
        
        backgroundColor = UIColor.rgb(red: 38, green: 38, blue: 38)
        
        [doneButton,urlField,refreshButton,spinner].forEach { addSubview($0) }
        
        _ = doneButton.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: nil,padding: .init(top: 0, left: 5, bottom: 0, right: 0),size: .init(width: frame.width/8, height: 0))
        
        urlField.positionInSuperView(size: .init(width: frame.width/1.5, height: frame.height/1.7), centerX: centerXAnchor, centerY: centerYAnchor)
        
        _ = refreshButton.anchor(top: urlField.topAnchor, bottom: urlField.bottomAnchor, leading: urlField.trailingAnchor, trailing: nil,size: .init(width: frame.width/8, height: 0))
        
        _ = spinner.anchor(top: urlField.topAnchor, bottom: urlField.bottomAnchor, leading: urlField.trailingAnchor, trailing: nil,size: .init(width: frame.width/8, height: 0))
    }
}
