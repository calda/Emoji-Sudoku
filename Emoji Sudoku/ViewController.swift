//
//  ViewController.swift
//  Emoji Sudoku
//
//  Created by Cal on 5/2/15.
//  Copyright (c) 2015 Cal Stephens. All rights reserved.
//

import UIKit

//pragma MARK: - Main View Controller

class ViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    @IBOutlet weak var screenView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delay(2.5) {
            self.loop()
        }
    }
    
    var currentPage = 0
    
    func loop() {
        currentPage++
        
        if self.currentPage == 15 {
            //loop back around
            self.currentPage = 2
            self.screenView.scrollToItemAtIndexPath(NSIndexPath(forItem: 1, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: false)
        }
        
        screenView.scrollToItemAtIndexPath(NSIndexPath(forItem: currentPage, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: true)
        delay(2.5) {
            self.loop()
        }
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let bundle = NSBundle.mainBundle()
        let imagePath = bundle.pathForResource("s\(indexPath.item)", ofType: "png")
        let data = NSData(contentsOfFile: imagePath!)
        let image = UIImage(data: data!)
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("screenshot", forIndexPath: indexPath) as! WatchImageCell
        cell.decorate(image)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return collectionView.frame.size
    }
    

}

//pragma MARK: - Watch Image Cell

class WatchImageCell : UICollectionViewCell {
    
    @IBOutlet weak var screenshot: UIImageView!
    
    func decorate(image: UIImage?) {
        screenshot.image = image
    }
    
}

func delay(delay:Double, closure:()->()) {
    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
    dispatch_after(time, dispatch_get_main_queue(), closure)
}

