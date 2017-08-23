//
//  PPWKWebViewController.swift
//  ios9WebviewSample
//
//  Created by ppengotsu on 2015/09/07.
//  Copyright © 2015年 ppengotsu. All rights reserved.
//


import UIKit
import WebKit

class PPWKWebViewController: UIViewController{
    
    @IBOutlet var baseView:UIView! //WKWebviewを設置するview
    var mainWebView: WKWebView!    //メインのwebview
    var viewUrlString: String = "" //前の画面で入力されたURL文字列
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //ボタン
        //ナビボタン追加
        let rightButton = UIBarButtonItem(title: "閉じる"
            , style:UIBarButtonItemStyle.plain , target: self, action:   #selector(self.touchedCloseButton(_:)))
        self.navigationItem.setRightBarButton(rightButton, animated: true)
        
        
        
        
        //メインのwebviewの設定
        self.mainWebView = WKWebView(frame: CGRect(x: 0,
                                                   y: 0,
                                                   width: baseView.frame.width,
                                                   height: baseView.frame.height))
        self.baseView.addSubview(self.mainWebView)
        
        let url: URL = URL(string: viewUrlString)!//前の画面で入力されたURL文字列を設定
        let urlRequest: URLRequest = URLRequest(url: url)
        self.mainWebView.load(urlRequest)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setURLString(_ urlString: String){
        
        viewUrlString = urlString
    }
    
    override func viewDidLayoutSubviews() {
        self.mainWebView.frame = CGRect(x: 0, y: 0, width: self.baseView.frame.width, height: self.baseView.frame.height)
        
        super.viewDidLayoutSubviews()
    }
    
    internal func touchedCloseButton(_ sender:UIButton){
        dismiss(animated: true, completion: nil)
    }
}


//WKWebviewのdelegate系列1
extension PPWKWebViewController:WKUIDelegate{
    
}


//WKWebviewのdelegate系列2
extension PPWKWebViewController:WKNavigationDelegate{
    
}

