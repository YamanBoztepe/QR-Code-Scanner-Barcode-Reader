//
//  WebViewController.swift
//  QR Code Scanner & Barcode Reader
//
//  Created by Yaman Boztepe on 21.02.2021.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    var webView: WKWebView!
    var url: URL?
    let extraView = UIView()
    let header = BackButtonHeader()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLayout()
        
        guard let url = url else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    fileprivate func setLayout() {
        
        let configuration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: configuration)
        
        [extraView,header,webView].forEach(view.addSubview(_:))
        
        _ = extraView.anchor(top: view.topAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        _ = header.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,size: .init(width: 0, height: view.frame.height/15))
        _ = webView.anchor(top: header.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        header.backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
    
    @objc fileprivate func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }

}
