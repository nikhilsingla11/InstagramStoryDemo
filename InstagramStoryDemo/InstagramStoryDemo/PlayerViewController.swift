//
//  PlayerViewController.swift
//  InstagramStoryDemo
//
//  Created by Aggarwal, Nikhil on 11/1/17.
//  Copyright © 2017 Aggarwal, Nikhil. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class PlayerViewController: UIViewController {
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var elapsedTime: UILabel!
    @IBOutlet weak var storyImage: UIImageView!
    var index = 0
    var fileIndex = 0
    var userProfiles : NSArray = []
    var stories = [["files":["pexels-photo-220453.jpeg"]],
                   ["files":["giphy.mp4"]],
                    ["files":["pexels-photo-264778.jpeg"]],
                    ["files":["output2.mp4"]],
                    ["files":["pexels-photo-415326.jpeg"]],
                    ["files":["668875033.mp4"]],
                    ["files":["pexels-photo-458470.jpeg"]],
                    ["files":["open_sign.mp4"]]]
    
    let playerViewController = AVPlayerViewController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setSwipeGesture()
        setup()
        playerViewController.view.frame = CGRect (x:0, y:50, width:view.frame.width, height:view.frame.height - 50)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func setup(){
        setUserProfile()
        setProgressBar()
        playStory()
    }
    
    func playStory(){
        let story = stories[index-1] as NSDictionary
        let files = story.object(forKey: "files") as! NSArray
        
        if fileIndex < files.count {
            let fileString = files[fileIndex] as! String
            let fileType = fileString.components(separatedBy: ".")
            if fileType[1] == "mp4"{
                storyImage.isHidden = true
                playVideo(fileName: fileType[0])
            }
            else{
                storyImage.isHidden = false
                let img = UIImage(named: fileString)
                storyImage.image = img
                playerViewController.view.removeFromSuperview()
                let deadlineTime = DispatchTime.now() + .seconds(5)
                DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                    if self.fileIndex == files.count - 1{
                         self.incrementIndex()
                    }
                   
                }
            }
        }
    }
    
//    func incrementSubIndex(){
//        fileIndex = fileIndex + 1
//        playStory()
//    }
    
    func setSwipeGesture(){
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToRightSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToLeftSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    func incrementIndex(){
        fileIndex = 0
        if index != userProfiles.count - 1 {
            index = index + 1
            setup()
        }
    }
    
    func respondToRightSwipeGesture(gesture: UIGestureRecognizer) {
        if index != 1 {
            index = index - 1
            setup()
        }
    }
    
    func respondToLeftSwipeGesture(gesture: UIGestureRecognizer) {
        incrementIndex()
    }
    
    func setUserProfile(){
        drawRect(imageView: imageview)
        let info = userProfiles[index] as! NSDictionary
        userName.text = info.object(forKey: "name") as? String
        let img = UIImage(named:(info.object(forKey: "image") as? String)!)
        imageview.image = img
        userName.sizeToFit()
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func drawRect(imageView : UIImageView){
        imageView.layer.cornerRadius = min(imageView.frame.size.height, imageView.frame.size.width) / 2.0
        imageView.layer.masksToBounds = true
    }
    
    func setProgressBar(){
        let spb = SegmentedProgressBar(numberOfSegments: 1, duration: 5)
        spb.frame = CGRect(x: 15, y: 5, width: view.frame.width - 30, height: 4)
        view.addSubview(spb)
        spb.topColor = UIColor.white
        spb.bottomColor = UIColor.white.withAlphaComponent(0.25)
        spb.padding = 2
        spb.startAnimation()
    }
    
    func segmentedProgressBarChangedIndex(index: Int) {
    }
    
    func playVideo(fileName : String){
        guard let path = Bundle.main.path(forResource: fileName, ofType:"mp4") else {
            debugPrint("video not found")
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        playerViewController.player = player
        player.play()
        self.addChildViewController(playerViewController)
        self.view.addSubview(playerViewController.view)
        playerViewController.didMove(toParentViewController: self)
        NotificationCenter.default.addObserver(self, selector: #selector(self.playerDidFinishPlaying),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
    }
    
    func playerDidFinishPlaying(note: NSNotification) {
        incrementIndex()
    }

}
