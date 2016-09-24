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
        currentPage += 1
        
        if self.currentPage == 15 {
            //loop back around
            self.currentPage = 1
            self.screenView.scrollToItem(at: IndexPath(item: 0, section: 0), at: UICollectionViewScrollPosition.centeredHorizontally, animated: false)
        }
        
        screenView.scrollToItem(at: IndexPath(item: currentPage, section: 0), at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
        delay(2.5) {
            self.loop()
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let bundle = Bundle.main
        let imagePath = bundle.path(forResource: "s\((indexPath as NSIndexPath).item)", ofType: "png")
        let data = try? Data(contentsOf: URL(fileURLWithPath: imagePath!))
        let image = UIImage(data: data!)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "screenshot", for: indexPath) as! WatchImageCell
        cell.decorate(image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    

}

//pragma MARK: - Watch Image Cell

class WatchImageCell : UICollectionViewCell {
    
    @IBOutlet weak var screenshot: UIImageView!
    
    func decorate(_ image: UIImage?) {
        screenshot.image = image
    }
    
}

func delay(_ delay:Double, closure:@escaping ()->()) {
    let time = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
    DispatchQueue.main.asyncAfter(deadline: time, execute: closure)
}

