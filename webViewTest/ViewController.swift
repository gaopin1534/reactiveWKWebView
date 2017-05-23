//
//  ViewController.swift
//  webViewTest
//
//  Created by gaopin1534 on 2017/05/19.
//  Copyright © 2017年 gaopin1534. All rights reserved.
//

import UIKit
import WebKit
import RxWebKit
import RxSwift

class ViewController: UIViewController {
    @IBOutlet weak var progressbar: UIProgressView!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var containerView: UIView!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up WKWebView
        let webview = WKWebView()
        webview.navigationDelegate = self
        webview.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(webview)
        setUpConstraints(for: webview)
        
        // load github.com
        let request = URLRequest(url: URL(string: "https://www.github.com")!)
        webview.load(request)
        
        // bind title to title label
        webview.rx.title.bind(to: titleLabel.rx.text).addDisposableTo(disposeBag)
        
        // handle back and forward buttons availablity
        webview.rx.canGoForward.asDriver(onErrorJustReturn: false).drive(forwardButton.rx.isEnabled).addDisposableTo(disposeBag)
        webview.rx.canGoBack.asDriver(onErrorJustReturn: false).drive(backButton.rx.isEnabled).addDisposableTo(disposeBag)
        
        // define on tap behavior of back, forward and refresh buttons
        backButton.rx.tap.asDriver().drive(onNext: {
            webview.goBack()
        }).addDisposableTo(disposeBag)
        
        forwardButton.rx.tap.asDriver().drive(onNext: {
            webview.goForward()
        }).addDisposableTo(disposeBag)
        
        refreshButton.rx.tap.asDriver().drive(onNext: {
            webview.reload()
        }).addDisposableTo(disposeBag)
        
        // set up progressbar
        containerView.bringSubview(toFront: progressbar)
        webview.rx.loading.asDriver(onErrorJustReturn: false).drive(progressbar.rx.appear).addDisposableTo(disposeBag)
        webview.rx.estimatedProgress.map { progress in
            return Float(progress)
        }.asDriver(onErrorJustReturn: 0.0).drive(progressbar.rx.progress).addDisposableTo(disposeBag)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setUpConstraints(for webview: WKWebView) {
        webview.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0.0).isActive = true
        webview.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0.0).isActive = true
        webview.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0.0).isActive = true
        webview.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0.0).isActive = true
    }

}

extension ViewController: WKNavigationDelegate {
    
}
