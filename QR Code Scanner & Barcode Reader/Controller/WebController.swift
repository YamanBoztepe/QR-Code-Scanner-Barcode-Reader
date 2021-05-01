//
//  WebController.swift
//  QR Code Scanner & Barcode Reader
//
//  Created by Yaman Boztepe on 27.04.2021.
//

import UIKit
import WebKit

class WebController: UIViewController {

    let extraView = UIView()
    let webBar = WebBar()
    let webView: WKWebView =  {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = prefs
        
        let wv = WKWebView(frame: .zero, configuration: configuration)
        return wv
    }()
    let webBottomBar = WebBottomBar()
    
    var url: URL = URL(string: "https://www.google.com")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.load(URLRequest(url: url))
        webView.navigationDelegate = self
        
        setLayout()
    }
    
    fileprivate func setLayout() {
        
        navigationController?.navigationBar.isHidden = true
        webBar.urlField.text = url.host?.shortURL()
        extraView.backgroundColor = UIColor.rgb(red: 38, green: 38, blue: 38)
        [extraView,webBar,webView,webBottomBar].forEach { view.addSubview($0) }
        
        _ = extraView.anchor(top: view.topAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        _ = webBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,size: .init(width: 0, height: view.frame.height/15))
        _ = webView.anchor(top: webBar.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        _ = webBottomBar.anchor(top: nil, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor,size: .init(width: 0, height: view.frame.height/15))
        
        webBar.doneButton.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
        webBar.refreshButton.addTarget(self, action: #selector(refreshButtonPressed), for: .touchUpInside)
        
        webBottomBar.backButton.addTarget(self, action: #selector(backButtonTarget), for: .touchUpInside)
        webBottomBar.forwardButton.addTarget(self, action: #selector(forwardButtonPressed), for: .touchUpInside)
        
        webBottomBar.shareButton.addTarget(self, action: #selector(shareButtonPressed), for: .touchUpInside)
        webBottomBar.safariButton.addTarget(self, action: #selector(safariButtonPressed), for: .touchUpInside)
    }
    
    @objc fileprivate func doneButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc fileprivate func refreshButtonPressed() {
        webView.reload()
    }
    
    @objc fileprivate func backButtonTarget() {
        
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @objc fileprivate func forwardButtonPressed() {
        
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    @objc fileprivate func shareButtonPressed() {
        
        guard let urlShare = webView.url else { return }
        
        let vc = UIActivityViewController(activityItems: [urlShare], applicationActivities: [])
        present(vc, animated: true)
    }
    
    @objc fileprivate func safariButtonPressed() {
        
        guard let safariURL = webView.url else { return }
        
        UIApplication.shared.open(safariURL)
    }
    
}

extension WebController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        webBar.spinner.startAnimating()
        webBar.refreshButton.isHidden = true
        
        guard let urlString = webView.url?.host else { return }
        webBar.urlField.text = urlString.shortURL()
        
        webBottomBar.backButton.isEnabled = webView.canGoBack
        webBottomBar.forwardButton.isEnabled = webView.canGoForward
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webBar.spinner.stopAnimating()
        webBar.refreshButton.isHidden = false
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        webBar.spinner.stopAnimating()
        webBar.refreshButton.isHidden = false
    }
}
