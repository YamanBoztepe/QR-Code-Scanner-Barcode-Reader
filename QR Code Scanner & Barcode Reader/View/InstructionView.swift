//
//  InstructionView.swift
//  QR Code Scanner & Barcode Reader
//
//  Created by Yaman Boztepe on 21.03.2021.
//

import UIKit

class InstructionView: UIView {
    
    
    fileprivate let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    fileprivate let historyButtonPlace = UIImageView(image: UIImage(systemName: "clock")?.withRenderingMode(.alwaysOriginal))
    fileprivate let generatorButtonPlace = UIImageView(image: UIImage(systemName: "plus.circle")?.withRenderingMode(.alwaysOriginal))
    fileprivate let scanImage = UIImageView(image: UIImage(named: "scanningLine")?.withRenderingMode(.alwaysOriginal))
    
    fileprivate let lblHistoryDesc: UILabel = {
        let lbl = UILabel()
        lbl.text = "Showing previous scans"
        lbl.numberOfLines = 0
        lbl.textColor = .white
        lbl.textAlignment = .center
        return lbl
    }()
    
    fileprivate let arrowRight = UIImageView(image: UIImage(systemName: "arrow.right"))
    
    fileprivate let topRightStackView: UIStackView = {
        let sv = UIStackView()
        sv.alignment = .center
        sv.axis = .horizontal
        sv.distribution = .fillProportionally
        return sv
    }()
    
    fileprivate let lblCreateQrDesc: UILabel = {
        let lbl = UILabel()
        lbl.text = "Creating a new qr code"
        lbl.numberOfLines = 0
        lbl.textColor = .white
        lbl.textAlignment = .center
        return lbl
    }()
    
    fileprivate let arrowLeft = UIImageView(image: UIImage(systemName: "arrow.left"))
    
    fileprivate let lblScanDesc: UILabel = {
        let lbl = UILabel()
        lbl.text = "Center the code to be scanned in the window above"
        lbl.numberOfLines = 0
        lbl.textColor = .white
        lbl.textAlignment = .center
        return lbl
    }()
    
    fileprivate let topLeftStackView: UIStackView = {
        let sv = UIStackView()
        sv.alignment = .center
        sv.axis = .horizontal
        sv.distribution = .fillProportionally
        return sv
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
        
        [arrowLeft,lblCreateQrDesc].forEach { topLeftStackView.addArrangedSubview($0) }
        [lblHistoryDesc,arrowRight].forEach { topRightStackView.addArrangedSubview($0) }
        [arrowUp,lblScanDesc].forEach { bottomStackView.addArrangedSubview($0) }
        
        addSubview(blurView)
        [topRightStackView, topLeftStackView, generatorButtonPlace, historyButtonPlace, scanImage, bottomStackView].forEach { blurView.contentView.addSubview($0) }
        
        _ = blurView.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor)
        _ = historyButtonPlace.anchor(top: blurView.topAnchor, bottom: nil, leading: nil, trailing: blurView.trailingAnchor,padding: .init(top: frame.width/10, left: 0, bottom: 0, right: -5), size: .init(width: frame.width/5, height: frame.height/9))
        
        _ = topRightStackView.anchor(top: historyButtonPlace.topAnchor, bottom: nil, leading: nil, trailing: historyButtonPlace.leadingAnchor,padding: .init(top: 0, left: 20, bottom: 0, right: 0), size: .init(width: frame.width/3.5, height: 0))
        
        _ = generatorButtonPlace.anchor(top: blurView.topAnchor, bottom: nil, leading: blurView.leadingAnchor, trailing: nil,padding: .init(top: frame.width/10, left: 5, bottom: 0, right: 0), size: .init(width: frame.width/5, height: frame.height/9))
        
        _ = topLeftStackView.anchor(top: generatorButtonPlace.topAnchor, bottom: nil, leading: generatorButtonPlace.trailingAnchor, trailing: topRightStackView.leadingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        _ = scanImage.anchor(top: nil, bottom: nil, leading: blurView.leadingAnchor, trailing: blurView.trailingAnchor,padding: .init(top: 0, left: 30, bottom: 0, right: -30))
        scanImage.positionInSuperView(size: .init(width: 0, height: frame.height/2), centerX: nil, centerY: blurView.centerYAnchor)
        
        _ = bottomStackView.anchor(top: scanImage.bottomAnchor, bottom: blurView.bottomAnchor, leading: blurView.leadingAnchor, trailing: blurView.trailingAnchor)
    }
}
