//
//  ViewController.swift
//  webViewTest
//
//  Created by 高松　幸平 on 2017/05/19.
//  Copyright © 2017年 高松　幸平. All rights reserved.
//

import UIKit
import WebKit
import RxWebKit
import RxSwift

class ViewController: UIViewController {
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var containerView: UIView!
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webview = WKWebView()
        webview.navigationDelegate = self
        webview.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(webview)

        webview.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0.0).isActive = true
        webview.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0.0).isActive = true
        webview.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0.0).isActive = true
        webview.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0.0).isActive = true
        
        let request = URLRequest(url: URL(string: "https://www.google.com")!)
        webview.load(request)
        
        webview.rx.title.subscribe(onNext: {
            print("title: \($0!)")
        }).addDisposableTo(disposeBag)
        
        webview.rx.url.subscribe(onNext: {
            print("title: \($0!)")
        }).addDisposableTo(disposeBag)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: WKNavigationDelegate {
    
}
