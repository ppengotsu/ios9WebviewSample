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
    
    @IBOutlet var baseWebView:UIView!
    var webView: WKWebView!
    var viewUrlString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //ボタン
        //ナビボタン追加
        let rightButton = UIBarButtonItem(title: "閉じる"
            , style:UIBarButtonItemStyle.Plain , target: self, action:   #selector(self.touchedCloseButton(_:)))
        self.navigationItem.setRightBarButtonItem(rightButton, animated: true)
        
        self.webView = WKWebView(frame: baseWebView.frame)
        self.baseWebView.addSubview(self.webView)
        
        let url: NSURL = NSURL(string: viewUrlString)!
        let urlRequest: NSURLRequest = NSURLRequest(URL: url)
        self.webView.loadRequest(urlRequest)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setURLString(urlString: String){
        
        viewUrlString = urlString
    }
    
    override func viewDidLayoutSubviews() {
        self.webView.frame = self.baseWebView.frame
    }
    
    internal func touchedCloseButton(sender:UIButton){
        dismissViewControllerAnimated(true, completion: nil)
    }
}
