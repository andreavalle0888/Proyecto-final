//
//  paginadeinicioViewController.swift
//  producto
//
//  Created by MacBook on 11/22/18.
//  Copyright © 2018 potato. All rights reserved.
//

import UIKit

class paginadeinicioViewController: UIViewController, UIScrollViewDelegate{
    
    @IBOutlet weak var pagecontrol: UIPageControl!
    @IBOutlet weak var scrollcontrol: UIScrollView!
    var galeriaimagenes: [String] = ["Template-One","Template-Two","Template-Three"]
    var frame = CGRect(x:0,y:0,width:0,height:0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pagecontrol.numberOfPages = galeriaimagenes.count
        for index in 0 ..< galeriaimagenes.count{
            frame.origin.x = scrollcontrol.frame.size.width * CGFloat(index)
            frame.size = scrollcontrol.frame.size
            let imgView = UIImageView(frame: frame)
            imgView.image = UIImage(named: galeriaimagenes[index])
            self.scrollcontrol.addSubview(imgView)
        }
        print("a")
        
        scrollcontrol.contentSize = CGSize(width: scrollcontrol.frame.size.width * CGFloat(galeriaimagenes.count), height: scrollcontrol.frame.size.height)
        scrollcontrol.delegate = self
        print("b")
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            stoppedScrolling()
        }
        print("c")
    }
    
    @objc func hadleSwipe(gesture: UISwipeGestureRecognizer){
        let originalLocation = self.scrollcontrol.center
        if gesture.direction == UISwipeGestureRecognizer.Direction.left{
            performSegue(withIdentifier: "toAplication", sender: nil)
            print("m")
        }
        print("d")
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var pagenumber = scrollcontrol.contentOffset.x / scrollcontrol.frame.size.width
        pagecontrol.currentPage = Int(pagenumber)
        stoppedScrolling()
        print("e")
    }
    
    func stoppedScrolling() {
        let swipeRigthGesture = UISwipeGestureRecognizer(target: self, action: #selector(hadleSwipe(gesture:)))
        swipeRigthGesture.direction = UISwipeGestureRecognizer.Direction.left
        scrollcontrol.addGestureRecognizer(swipeRigthGesture)
        print("f")
    }
    
}
