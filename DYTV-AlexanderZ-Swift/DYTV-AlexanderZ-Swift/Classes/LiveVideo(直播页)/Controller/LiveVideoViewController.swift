////
////  LiveVideoViewController.swift
////  DYTV-AlexanderZ-Swift
////
////  Created by Alexander Zou on 16/10/12.
////  Copyright © 2016年 Alexander Zou. All rights reserved.
////
//
//import UIKit
//import IJKMediaFramework
//
//class LiveVideoViewController: UIViewController {
//
//    var player : IJKFFMoviePlayerController!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        self.view.backgroundColor = UIColor.blueColor()
//        
//        let options = IJKFFOptions.optionsByDefault()
//        
//        let url = NSURL(string: "rtmp://live.hkstv.hk.lxdns.com/live/hks")
//        
//        let player = IJKFFMoviePlayerController(contentURL: url, withOptions: options)
//        
//        let autoresize = UIViewAutoresizing.FlexibleWidth.rawValue |
//            UIViewAutoresizing.FlexibleHeight.rawValue
//        
//        player.view.autoresizingMask = UIViewAutoresizing(rawValue: autoresize)
//        
//        player.view.frame = self.view.bounds
//        player.scalingMode = .AspectFit
//        player.shouldAutoplay = true
//        
//        self.view.autoresizesSubviews = true
//        self.view.addSubview(player.view)
//        self.player = player
//        
//        
//    }
//    
//    override func viewWillAppear(animated: Bool) {
//        self.player.prepareToPlay()
//    }
//    
//    override func viewWillDisappear(animated: Bool) {
//        self.player.shutdown()
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
