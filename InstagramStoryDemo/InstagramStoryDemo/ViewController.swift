//
//  ViewController.swift
//  InstagramStoryDemo
//
//  Created by Aggarwal, Nikhil on 11/1/17.
//  Copyright © 2017 Aggarwal, Nikhil. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource {
    @IBOutlet weak var storyTableview: UITableView!
    let userProfiles = [["name":"Nikhil","image":"nikhil.jpg"],
                        ["name":"Andrew","image":"pexels-photo-220453.jpeg"],
                        ["name":"Robin","image":"pexels-photo-257558.jpeg"],
                        ["name":"Akshay","image":"pexels-photo-264778.jpeg"],
                        ["name":"Nancy","image":"pexels-photo-302053.jpeg"],
                        ["name":"John","image":"pexels-photo-415326.jpeg"],
                        ["name":"Tarun","image":"pexels-photo-452558.jpeg"],
                        ["name":"Angelina","image":"pexels-photo-458470.jpeg"],
                        ["name":"Nandy","image":"pexels-photo.jpg"]]

    override func viewDidLoad() {
        super.viewDidLoad()
        storyTableview.dataSource = self
        storyTableview.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func drawRect(imageView : UIImageView){
        imageView.layer.cornerRadius = min(imageView.frame.size.height, imageView.frame.size.width) / 2.0
        imageView.layer.masksToBounds = true
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
                                                 for: indexPath) as! storyTableViewCell
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 9
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let info = userProfiles[indexPath.row] as NSDictionary
        if indexPath.row == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionCell",
                                                          for: indexPath as IndexPath) as! ProfileCollectionViewCell
            cell.profileName.text = info.object(forKey: "name") as? String
            let img = UIImage(named:(info.object(forKey: "image") as? String)!)
            cell.profileImage.image = img
            drawRect(imageView: cell.profileImage)
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell",
                                                          for: indexPath as IndexPath) as! StoriesCollectionViewCell
            cell.name.text = info.object(forKey: "name") as? String
            cell.imageView.image = UIImage(named:(info.object(forKey: "image") as? String)!)
            drawRect(imageView: cell.imageView)
            return cell
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 90, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0{
            
        }
        else{
            let storyBoard = UIStoryboard(name:"Player", bundle: nil)
            let controller = storyBoard.instantiateViewController(withIdentifier: "PlayerSB") as! PlayerViewController
            controller.index = indexPath.row
            controller.userProfiles = userProfiles as NSArray
            self.present(controller, animated: true, completion: nil)
        }
    }
    

}

