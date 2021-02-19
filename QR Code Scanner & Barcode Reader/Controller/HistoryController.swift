//
//  HistoryController.swift
//  QR Code Scanner & Barcode Reader
//
//  Created by Yaman Boztepe on 15.02.2021.
//

import UIKit

class HistoryController: UIViewController {

    fileprivate let extraView = UIView()
    fileprivate let header = HeaderOfHC()
    fileprivate let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        navigationController?.navigationBar.isHidden = true
    }
    
    fileprivate func setLayout() {
        
        extraView.backgroundColor = header.backgroundColor
        tableView.backgroundColor = .darkGray
        
        [extraView,header,tableView].forEach(view.addSubview(_:))
        
        _ = extraView.anchor(top: view.topAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        _ = header.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,size: .init(width: 0, height: view.frame.height/15))
        _ = tableView.anchor(top: header.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        header.backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        
        setTableView()
    }
    
    fileprivate func setTableView() {
        tableView.register(HistoryCell.self, forCellReuseIdentifier: HistoryCell.IDENTIFIER)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc fileprivate func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension HistoryController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryCell.IDENTIFIER, for: indexPath) as? HistoryCell else { return UITableViewCell()}
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height/10
    }
    
}
