//
//  PPUIWebViewController.swift
//  ios9WebviewSample
//
//  Created by ppengotsu on 2015/09/07.
//  Copyright © 2015年 ppengotsu. All rights reserved.
//

import UIKit


class PPUIWebViewController: UIViewController{
    
    var webView: UIWebView = UIWebView()
    var viewUrlString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //ボタン
        let closeButton: UIButton = UIButton();
        closeButton.frame = CGRectMake(self.view.frame.width - 100, 50, 100, 50)
        closeButton.setTitle("閉じる", forState:UIControlState.Normal)
        closeButton.addTarget(self, action: "touchedCloseButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(closeButton)
        
        //WebView
        self.webView.frame = CGRect(x: 0, y: 100, width: self.view.bounds.width, height: self.view.bounds.height - 100)
        //webview.delegate = self;
        self.view.addSubview(self.webView)
        
       
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
    
    
    internal func touchedCloseButton(sender:UIButton){
        dismissViewControllerAnimated(true, completion: nil)
    }
}

