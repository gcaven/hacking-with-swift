//
//  ViewController.swift
//  EasyBrowser
//
//  Created by Geoffrey Caven on 2019-05-28.
//  Copyright © 2019 Geoffrey Caven. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
  
  var webView: WKWebView!
  var progressView: UIProgressView!
  var websites = ["apple.com","hackingwithswift.com","caven.codes"]
  
  override func loadView() {
    webView = WKWebView()
    webView.navigationDelegate = self
    view = webView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
    
    progressView = UIProgressView(progressViewStyle: .default)
    progressView.sizeToFit()
    let progressButton = UIBarButtonItem(customView: progressView)
    
    let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
    let back = UIBarButtonItem(title: "Back", style: .plain, target: webView, action: #selector(webView.goBack))
    let forward = UIBarButtonItem(title: "Forward", style: .plain, target: webView, action: #selector(webView.goForward))
    toolbarItems = [progressButton, spacer, back, forward, refresh]
    navigationController?.isToolbarHidden = false

    let url = URL(string: "https://\(websites[0])")!
    webView.load(URLRequest(url: url))
    
    webView.allowsBackForwardNavigationGestures = true
    webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
  }
  
  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    if keyPath == "estimatedProgress" {
      progressView.progress = Float(webView.estimatedProgress)
    }
  }
  
  @objc func openTapped() {
    let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
    for website in websites {
      ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
    }
    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
    present(ac, animated: true)
  }
  
  func openPage(action: UIAlertAction) {
    let url = URL(string: "https://\(action.title!)")!
    webView.load(URLRequest(url: url))
  }
  
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    title = webView.title
  }

  func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    let url = navigationAction.request.url
    if let host = url?.host {
      var validHost = false
      for website in websites {
        if host.contains(website) {
          validHost = true
        }
      }
      if validHost {
        decisionHandler(.allow)
        return
      } else {
        decisionHandler(.cancel)
        let ac = UIAlertController(title: "This URL is not allowed", message: "loading of \"\(host)\" aborted", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        return
      }
    }
    decisionHandler(.cancel)
  }
}

