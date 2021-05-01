//
//  QRGeneratorView.swift
//  QR Code Scanner & Barcode Reader
//
//  Created by Yaman Boztepe on 8.04.2021.
//

import UIKit

class QRGeneratorView: UIView {
    
    let header = BackButtonHeader()
    
    let txtData: UITextField = {
        let txt = UITextField()
        txt.backgroundColor = .white
        txt.textColor = .black
        txt.placeholder = "Write something..."
        txt.attributedPlaceholder = NSAttributedString(string: txt.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        txt.textAlignment = .left
        txt.contentVerticalAlignment = .top
        txt.addDoneButtonOnKeyboard()
        return txt
    }()
    let btnGenerate: UIButton = {
        let btn = UIButton()
        btn.setTitle("Generate", for: .normal)
        btn.backgroundColor = UIColor.rgb(red: 38, green: 38, blue: 38)
        btn.isEnabled = false
        return btn
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setLayout()
    }
    
    fileprivate func setLayout() {
        
        backgroundColor = btnGenerate.backgroundColor
        [header, txtData, btnGenerate].forEach { addSubview($0) }
        
        _ = header.anchor(top: topAnchor, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor, size: .init(width: 0, height: frame.height/15))
        _ = txtData.anchor(top: header.bottomAnchor, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor, size: .init(width: 0, height: frame.height/1.5))
        _ = btnGenerate.anchor(top: txtData.bottomAnchor, bottom: nil, leading: nil, trailing: nil, padding: .init(top: 20, left: 0, bottom: 0, right: 0), size: .init(width: frame.width/3, height: frame.width/3))
        btnGenerate.positionInSuperView(centerX: centerXAnchor, centerY: nil)
        
        btnGenerate.layer.cornerRadius = frame.width/6
        btnGenerate.layer.borderWidth = 5
        btnGenerate.layer.borderColor = UIColor.gray.withAlphaComponent(0.3).cgColor
        btnGenerate.setTitleColor(UIColor.gray.withAlphaComponent(0.3), for: .normal)
        
        header.lblTitle.text = "Generation"
    }
    
    
    
}
