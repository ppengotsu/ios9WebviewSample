//
//  ViewController.swift
//  ios9WebviewSample
//
//  Created by ppengotsu on 2015/08/22.
//  Copyright © 2015年 ppengotsu. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet var urlTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        urlTextField.delegate = self;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: テキストフィールド
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    // MARK: URLチェック
    /**
    urlとして正しいか
    
    :returns: 正しければtrue
    */
    func isInputURL(_ urlString:String) -> Bool{
        NSLog("URL=%@", urlString)
        
        if (urlString .hasPrefix("http://")
            || urlString .hasPrefix("https://")
            || urlString .hasPrefix("file://")){
            
                return true
        }
        
        //満たない場合
        return false
    }
    
    // MARK: アラート
    func showUrlAlert(){
        let alertController:UIAlertController = UIAlertController(title: "URL不備",
            message: "URLの確認してください。",
            preferredStyle: UIAlertControllerStyle.alert)
        
        
        let cancelAction:UIAlertAction = UIAlertAction(title: "はい",
            style: UIAlertActionStyle.cancel,
            handler: {
                (action:UIAlertAction!) -> Void in
        })
        
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: ボタン押した時
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //ちょっとごり押し
        if segue.identifier == "webView" {
            let nextNavigationController = segue.destination as! UINavigationController
            let nextViewController = nextNavigationController.viewControllers[0] as! PPUIWebViewController
            nextViewController.viewUrlString = urlTextField.text!
            
        }else if segue.identifier == "wkWebView" {
            let nextNavigationController = segue.destination as! UINavigationController
            let nextViewController = nextNavigationController.viewControllers[0] as! PPWKWebViewController
            nextViewController.viewUrlString = urlTextField.text!
        }
    }
    
    
    
    /**
    SFSafariViewControllerボタンを押したとき
    
    :param: sender
    */
    @IBAction func touchedSFSafariViewControllerButton(_ sender: AnyObject){
        let urlString:String = urlTextField.text!
        if (isInputURL(urlString) == false){
            //URLが正しくない
            showUrlAlert()
            return
        }
        
        let safariVC = SFSafariViewController(url: URL(string: urlString)!)
        
        
        present(safariVC, animated: true, completion: nil)
    }
    
    /**
    標準Safariボタンを押したとき
    
    :param: sender
    */
    @IBAction func touchedNormalSafariButton(_ sender: AnyObject){
        let urlString:String = urlTextField.text!
        if (isInputURL(urlString) == false){
            //URLが正しくない
            showUrlAlert()
            return
        }
        
        UIApplication.shared.openURL(URL(string: urlString)!)
        
        
    }


}

