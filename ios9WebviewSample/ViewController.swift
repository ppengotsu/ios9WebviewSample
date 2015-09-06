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
    func textFieldDidBeginEditing(textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    // MARK: URLチェック
    /**
    urlとして正しいか
    
    :returns: 正しければtrue
    */
    func isInputURL(let urlString:String) -> Bool{
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
            preferredStyle: UIAlertControllerStyle.Alert)
        
        
        let cancelAction:UIAlertAction = UIAlertAction(title: "はい",
            style: UIAlertActionStyle.Cancel,
            handler: {
                (action:UIAlertAction!) -> Void in
        })
        
        alertController.addAction(cancelAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: ボタン押した時
    
    /**
    UIWebViewボタンを押したとき
    
    :param: sender
    */
    @IBAction func touchedUIWebViewButton(sender: AnyObject){
        let urlString:String = urlTextField.text!
        if (isInputURL(urlString) == false){
            //URLが正しくない
            showUrlAlert()
            return
        }
        
        let vc: PPUIWebViewController =  PPUIWebViewController()
        vc.setURLString(urlString)
        presentViewController(vc, animated: true, completion: nil)
    }
    
    /**
    WKWebViewボタンを押したとき
    
    :param: sender
    */
    @IBAction func touchedWKWebViewButton(sender: AnyObject){
        let urlString:String = urlTextField.text!
        if (isInputURL(urlString) == false){
            //URLが正しくない
            showUrlAlert()
            return
        }
        
        let vc: PPWKWebViewController =  PPWKWebViewController()
        vc.setURLString(urlString)
        presentViewController(vc, animated: true, completion: nil)
        
        
    }
    
    /**
    SFSafariViewControllerボタンを押したとき
    
    :param: sender
    */
    @IBAction func touchedSFSafariViewControllerButton(sender: AnyObject){
        let urlString:String = urlTextField.text!
        if (isInputURL(urlString) == false){
            //URLが正しくない
            showUrlAlert()
            return
        }
        
        let safariVC = SFSafariViewController(URL: NSURL(string: urlString)!)
        
        
        presentViewController(safariVC, animated: true, completion: nil)
    }
    
    /**
    標準Safariボタンを押したとき
    
    :param: sender
    */
    @IBAction func touchedNormalSafariButton(sender: AnyObject){
        let urlString:String = urlTextField.text!
        if (isInputURL(urlString) == false){
            //URLが正しくない
            showUrlAlert()
            return
        }
        
        UIApplication.sharedApplication().openURL(NSURL(string: urlString)!)
        
        
    }


}

