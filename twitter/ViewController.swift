//
//  ViewController.swift
//  twitter
//
//  Created by 迫 佑樹 on 2016/01/04.
//  Copyright © 2016年 迫 佑樹. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController, UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    var image = UIImagePickerController()
    
    @IBAction func importLibrary(sender: AnyObject) {
        
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(image, animated: true, completion: nil)
    
    }
    
    @IBAction func takePhoto(sender: AnyObject) {

        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(image, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        print("Image Selected")
        self.dismissViewControllerAnimated(true, completion: nil)
        imageView.image = image
        
        print(image)
        
    }
    
    @IBOutlet var imageView: UIImageView!
    
    var myComposeView : SLComposeViewController!
    var myTwitterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Twitter用のUIButtonの生成.
        let hex: Int = 0x55ACEE
        let red = Double((hex & 0xFF0000) >> 16) / 255.0
        let green = Double((hex & 0xFF00) >> 8) / 255.0
        let blue = Double((hex & 0xFF)) / 255.0
        var myColor: UIColor = UIColor( red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(1.0))
        
        // ボタン.
        myTwitterButton = UIButton()
        myTwitterButton.frame = CGRectMake(0,0,100,100)
        myTwitterButton.backgroundColor = myColor
        myTwitterButton.layer.masksToBounds = true
        myTwitterButton.setTitle("Twitter", forState: UIControlState.Normal)
        myTwitterButton.titleLabel?.font = UIFont.systemFontOfSize(CGFloat(20))
        myTwitterButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        myTwitterButton.layer.cornerRadius = 50.0
        myTwitterButton.layer.position = CGPoint(x: self.view.frame.width/2, y:self.view.frame.height/8 * 7)
        myTwitterButton.tag = 1
        myTwitterButton.addTarget(self, action: "onPostToTwitter:", forControlEvents: .TouchUpInside)
        
        // buttonをviewに追加.
        self.view.addSubview(myTwitterButton)
        
        
    }
    
    // ボタンイベント.
    func onPostToTwitter(sender : AnyObject) {
        
        // SLComposeViewControllerのインスタンス化.
        // ServiceTypeをTwitterに指定.
        myComposeView = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        
        // 投稿するテキストを指定.
        myComposeView.setInitialText("クレイジー画像あげるお(´・∀・｀) @kusorep_crazy")
        
        // 投稿する画像を指定.
        myComposeView.addImage(imageView.image)
        
        // myComposeViewの画面遷移.
        self.presentViewController(myComposeView, animated: true, completion: nil)
    }
    
}
