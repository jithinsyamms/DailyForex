//
//  ForexIemViewController.swift
//  DailyForex
//
//  Created by Jithin on 01/01/22.
//

import UIKit
import WebKit

class ForexIemViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    
    var forexItem:ForexItem?
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: forexItem?.url ?? ""){
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
        }
    }

}
