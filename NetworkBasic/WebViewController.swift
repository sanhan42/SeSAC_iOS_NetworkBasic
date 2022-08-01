//
//  WebViewController.swift
//  NetworkBasic
//
//  Created by 한상민 on 2022/07/28.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
//    static var reuseIdentifier: String = String(describing: WebViewController.self) // "WebViewController" 메타타입의 활용
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var webView: WKWebView!
    
    var destinationURL: String = "https://www.apple.com" // App Transport Scurity Settings
    // cf. SkeletonView 라이브러리 추가해서 로딩화면을 설정해줄 수 있다.
    override func viewDidLoad() {
        super.viewDidLoad()

        openWebPage(url: destinationURL)
        searchBar.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func goBackButtonClicked(_ sender: UIBarButtonItem) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func reloadButtonClicked(_ sender: UIBarButtonItem) {
        webView.reload()
    }
    
    @IBAction func goForwardButtonClicked(_ sender: UIBarButtonItem) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    func openWebPage(url:String) {
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url:url)
        webView.load(request)
    }
}

extension WebViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        openWebPage(url: searchBar.text!)
    }
}
