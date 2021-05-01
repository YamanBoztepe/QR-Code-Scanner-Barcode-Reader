//
//  HistoryController.swift
//  QR Code Scanner & Barcode Reader
//
//  Created by Yaman Boztepe on 15.02.2021.
//

import UIKit
import CoreData

class HistoryController: UIViewController {

    fileprivate let extraView = UIView()
    fileprivate let header = BackButtonHeader()
    fileprivate let tableView = UITableView()

    var metadataList = [ScanOutput]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestAds()
        setLayout()
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadData()
    }
    
    fileprivate func setLayout() {
        
        extraView.backgroundColor = UIColor.rgb(red: 23, green: 23, blue: 23)
        tableView.backgroundColor = UIColor.rgb(red: 38, green: 38, blue: 38)
        tableView.separatorStyle = .none
        
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
    
    fileprivate func loadData() {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let request = NSFetchRequest<ScanOutput>(entityName: "ScanOutput")
        
        do {
            
            metadataList = try managedContext.fetch(request)
            metadataList.reverse()
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    @objc fileprivate func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension HistoryController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return metadataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryCell.IDENTIFIER, for: indexPath) as? HistoryCell else { return UITableViewCell()}
        
        let selectedMetadata = metadataList[indexPath.row]
        cell.setData(data: selectedMetadata)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height/10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let stringValue = metadataList[indexPath.row].metadata else { return }
        presentOutput(stringValue: stringValue)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        if editingStyle == .delete {
            
            let selectedMetadata = metadataList[indexPath.row]
            managedContext.delete(selectedMetadata)
            metadataList.remove(at: indexPath.row)
            
            do {
                
                try managedContext.save()
                self.tableView.reloadData()
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) as? HistoryCell else { return }
        cell.lblMetaData.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        
        if let indexPath = indexPath {
            guard let cell = tableView.cellForRow(at: indexPath) as? HistoryCell else { return }
            cell.lblMetaData.isHidden = false
        }
    }
}
