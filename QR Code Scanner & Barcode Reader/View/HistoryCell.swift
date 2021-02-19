//
//  HistoryCell.swift
//  QR Code Scanner & Barcode Reader
//
//  Created by Yaman Boztepe on 17.02.2021.
//

import UIKit

class HistoryCell: UITableViewCell {
    
    static let IDENTIFIER = "HistoryCell"
    
    fileprivate let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    fileprivate let lblDate: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.text = "00/00/0000"
        return lbl
    }()
    
    fileprivate let lblMetaData: UILabel = {
        let lbl = UILabel()
        lbl.text = " "
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        var i = 0
        while i < Int(frame.width/3) {
            
            lblMetaData.text! += " "
            i += 1
        }
        
        lblMetaData.text! += "123456789123456789123456789123456789123456789123456789123456789123456789123456789123456789123456789123456789123456789123456789123456789123456789123456789123456789123456789"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setLayout()
    }
    
    
    fileprivate func setLayout() {
        
        backgroundColor = .clear
        selectionStyle = .none
        
        [lblDate,lblMetaData].forEach(cellView.addSubview(_:))
        addSubview(cellView)
        
        _ = cellView.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor,padding: .init(top: frame.height/10, left: 0, bottom: 0, right: 0))
        _ = lblDate.anchor(top: cellView.topAnchor, bottom: nil, leading: cellView.leadingAnchor, trailing: nil,padding: .init(top: frame.height/10, left: frame.width/3.5, bottom: 0, right: 0))
        _ = lblMetaData.anchor(top: lblDate.bottomAnchor, bottom: cellView.bottomAnchor, leading: cellView.leadingAnchor, trailing: nil, padding: .init(top: frame.height/10, left: 0, bottom: 0, right: 0))
        
        lblDate.font = UIFont.boldSystemFont(ofSize: frame.width/15)
        
        guard let wordCounter = lblMetaData.text?.count else { return }
        let duration = Double(wordCounter/16)
        self.lblMetaData.slideAnimation(duration: duration)

    }
    
    required init?(coder: NSCoder) {
        fatalError("Error")
    }
}
