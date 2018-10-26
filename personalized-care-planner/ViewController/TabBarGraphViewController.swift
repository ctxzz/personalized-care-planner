//
//  TabBarGraphViewController.swift
//  personalized-care-planner
//
//  Created by Atsushi OMATA on 2018/10/20.
//  Copyright © 2018 Kirilab. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class TabBarGraphViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Graph"
        
        prepareWebView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
}

extension TabBarGraphViewController {
    func prepareWebView() {
        webView = WKWebView.init(frame: self.view.frame)
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
                
        if let htmlData = Bundle.main.path(forResource: "index", ofType: "html") {
            webView.load(URLRequest(url: URL(fileURLWithPath: htmlData)))
            view.layout(webView).edges()
        } else {
            print("file not found")
        }
    }
}
