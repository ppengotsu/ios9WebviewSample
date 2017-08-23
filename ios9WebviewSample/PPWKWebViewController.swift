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
    
    //WKWebviewを設置するview
    @IBOutlet var baseView:UIView!
    
    //メインのwebview
    var mainWebView: WKWebView!
    
    //ポップウィンドウ用のwkwebview. 普段は非表示。ポップアップ処理があるときのみ表示される
    var popupWindowWebview:WKWebView!
    
    //前の画面で入力されたURL文字列
    var viewUrlString: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //ボタン
        //ナビボタン追加
        let rightButton = UIBarButtonItem(title: "閉じる"
            , style:UIBarButtonItemStyle.plain , target: self, action:   #selector(self.touchedCloseButton(_:)))
        self.navigationItem.setRightBarButton(rightButton, animated: true)
        
        
        //キャッシュ系列削除
        self.deleteAllWebviewCache()
        
        
        //メインのwebviewの設定
        self.mainWebView = WKWebView(frame: CGRect(x: 0,
                                                   y: 0,
                                                   width: baseView.frame.width,
                                                   height: baseView.frame.height))
        self.baseView.addSubview(self.mainWebView)
        
        self.mainWebView.uiDelegate = self
        self.mainWebView.navigationDelegate = self
        
        let url: URL = URL(string: viewUrlString)!//前の画面で入力されたURL文字列を設定
        let urlRequest: URLRequest = URLRequest(url: url)
        self.mainWebView.load(urlRequest)
        
    }
    
    override func viewDidLayoutSubviews() {
        self.mainWebView.frame = CGRect(x: 0, y: 0, width: self.baseView.frame.width, height: self.baseView.frame.height)
        
        if(self.popupWindowWebview != nil){
            self.popupWindowWebview.frame = CGRect(x: 0, y: 0, width: self.baseView.frame.width, height: self.baseView.frame.height)
        }
        
        super.viewDidLayoutSubviews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:  データ操作系
    
    //wkwebview系列の全てのキャッシュを削除
    //ログイン状態などが解除されます
    func deleteAllWebviewCache(){
         //(参考：http://qiita.com/bbq-all-stars/items/b107693f61278d75bd69）
        
        // WKWebView用キャッシュ削除
        let websiteDataTypes = NSSet(array: [
            WKWebsiteDataTypeDiskCache,
            WKWebsiteDataTypeMemoryCache,
            WKWebsiteDataTypeCookies,
            WKWebsiteDataTypeLocalStorage,
            WKWebsiteDataTypeSessionStorage,
            WKWebsiteDataTypeWebSQLDatabases,
            WKWebsiteDataTypeIndexedDBDatabases,
            WKWebsiteDataTypeOfflineWebApplicationCache])
        WKWebsiteDataStore.default().removeData(ofTypes: websiteDataTypes as! Set<String>, modifiedSince: Date(timeIntervalSince1970: 0), completionHandler: {})
        
        // アプリ全体のキャッシュをとにかく削除
        let pathArray = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, .userDomainMask, true)
        for path in pathArray {
            //ライブラリディレクトリのキャッシュディレクトリを削除
            try? FileManager().removeItem(atPath: path)
        }
        
        ////ライブラリディレクトリのテンポラリディレクトリを削除
        try? FileManager().removeItem(atPath: NSTemporaryDirectory())
    }
    
    
    // MARK: 外部クラスからの操作系
    
    func setURLString(_ urlString: String){
        
        viewUrlString = urlString
    }
    
    // MARK:   ボタンアクション系
    
    internal func touchedCloseButton(_ sender:UIButton){
        dismiss(animated: true, completion: nil)
    }
}


// MARK:  - WKWebviewのdelegate系列1
extension PPWKWebViewController:WKUIDelegate{
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        
        
        //_blank対応　参考：http://qiita.com/milkit/items/a23b0b109f434a28ab8b
        //ウィンドウを開くような処理(例：window.open)がよばれたとき
        if navigationAction.targetFrame == nil {
            
            //ウィンドウを開くところを、メインのwebview以外のwebviewで表示することで、
            //対応する
            if(self.popupWindowWebview != nil){
              self.popupWindowWebview.removeFromSuperview()//前表示していたら削除
            }
            self.popupWindowWebview = WKWebView(frame: CGRect(x: 0,
                                                              y: 0,
                                                              width: self.baseView.frame.width,
                                                              height: self.baseView.frame.height),
                                                configuration: configuration)
            self.popupWindowWebview.uiDelegate = self
            self.popupWindowWebview.navigationDelegate = self
            self.popupWindowWebview.load(navigationAction.request)
            self.baseView.addSubview(self.popupWindowWebview)
            return self.popupWindowWebview
        }
        
        return nil
        
        
        
    }
    
    
    func webViewDidClose(_ webView: WKWebView) {
        print("javascriptでwindow.closeなどが呼ばれた")

        self.popupWindowWebview.removeFromSuperview()
    }
}




// MARK:  - WKWebviewのdelegate系列2
extension PPWKWebViewController:WKNavigationDelegate{
    
    
    //実行中のプロセスが死んだときに呼ばれる
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        print("実行中のプロセスが死にました。リロードします。")
        webView.reload()
    }
}

