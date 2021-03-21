//
//  InstructionView.swift
//  QR Code Scanner & Barcode Reader
//
//  Created by Yaman Boztepe on 21.03.2021.
//

import UIKit

class InstructionView: UIView {
    
    
    fileprivate let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    fileprivate let historyButtonPlace = UIImageView(image: UIImage(named: "HistoryButton")?.withRenderingMode(.alwaysOriginal))
    fileprivate let scanImage = UIImageView(image: UIImage(named: "scanningLine")?.withRenderingMode(.alwaysOriginal))
    
    fileprivate let lblHistoryDesc: UILabel = {
        let lbl = UILabel()
        lbl.text = "You can see previous scans in this section"
        lbl.numberOfLines = 0
        lbl.textColor = .white
        lbl.textAlignment = .center
        return lbl
    }()
    
    fileprivate let arrowRight = UIImageView(image: UIImage(systemName: "arrow.right"))
    
    fileprivate let topStackView: UIStackView = {
        let sv = UIStackView()
        sv.alignment = .center
        sv.axis = .horizontal
        sv.distribution = .fillProportionally
        return sv
    }()
    
    fileprivate let lblScanDesc: UILabel = {
        let lbl = UILabel()
        lbl.text = "Center the code to be scanned in the window above"
        lbl.numberOfLines = 0
        lbl.textColor = .white
        lbl.textAlignment = .center
        return lbl
    }()
    
    fileprivate let arrowUp = UIImageView(image: UIImage(systemName: "arrow.up"))
    
    fileprivate let bottomStackView: UIStackView = {
        let sv = UIStackView()
        sv.alignment = .center
        sv.axis = .vertical
        sv.distribution = .fillProportionally
        return sv
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setLayout()
    }
    
    fileprivate func setLayout() {
        
        [lblHistoryDesc,arrowRight].forEach { topStackView.addArrangedSubview($0) }
        [arrowUp,lblScanDesc].forEach { bottomStackView.addArrangedSubview($0) }
        
        addSubview(blurView)
        [topStackView, historyButtonPlace, scanImage, bottomStackView].forEach { blurView.contentView.addSubview($0) }
        
        _ = blurView.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor)
        _ = historyButtonPlace.anchor(top: blurView.topAnchor, bottom: nil, leading: nil, trailing: blurView.trailingAnchor,padding: .init(top: frame.width/10, left: 0, bottom: 0, right: -5), size: .init(width: frame.width/5, height: frame.height/9))
        
        _ = topStackView.anchor(top: historyButtonPlace.topAnchor, bottom: historyButtonPlace.bottomAnchor, leading: blurView.leadingAnchor, trailing: historyButtonPlace.leadingAnchor,padding: .init(top: 0, left: 20, bottom: 0, right: 0))
        
        _ = scanImage.anchor(top: nil, bottom: nil, leading: blurView.leadingAnchor, trailing: blurView.trailingAnchor,padding: .init(top: 0, left: 30, bottom: 0, right: -30))
        scanImage.positionInSuperView(size: .init(width: 0, height: frame.height/2), centerX: nil, centerY: blurView.centerYAnchor)
        
        _ = bottomStackView.anchor(top: scanImage.bottomAnchor, bottom: blurView.bottomAnchor, leading: blurView.leadingAnchor, trailing: blurView.trailingAnchor)
    }
}
