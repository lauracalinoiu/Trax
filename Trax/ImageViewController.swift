//
//  ViewController.swift
//  Cassini
//
//  Created by Laura Calinoiu on 08/08/16.
//  Copyright © 2016 3smurfs. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
  
  var imageURL: NSURL!{
    didSet{
      image = nil
      if imageView.window != nil{
        fetchImage()
      }
    }
  }
  
  var image: UIImage!{
    get{
      return imageView
        .image
    }
    set{
      imageView.image = newValue
      imageView.sizeToFit()
      scrollView?.contentSize = imageView.frame.size
      spinner?.stopAnimating()
    }
  }
  
  var imageView: UIImageView = UIImageView()
  @IBOutlet weak var scrollView: UIScrollView!{
    didSet{
      scrollView.contentSize = imageView.frame.size
      scrollView.delegate = self
      scrollView.minimumZoomScale = 0.03
      scrollView.maximumZoomScale = 1.0
    }
  }
  @IBOutlet weak var spinner: UIActivityIndicatorView!
  
  func fetchImage(){
    if let url = imageURL{
      spinner.startAnimating()
      dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)){
        if let data = NSData(contentsOfURL: url){
          
          dispatch_async(dispatch_get_main_queue()){
            if url == self.imageURL{
              self.image = UIImage(data: data)
            } else{
              print("abandoned to show image returned since user changed his mind")
            }
          }
        } else {
          self.spinner.stopAnimating()
        }
      }
    }
  }
  
  func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
    return imageView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    scrollView.addSubview(imageView)
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    if image == nil{
      fetchImage()
    }
    
  }
  
}

extension UIViewController{
  var contentViewController : UIViewController{
    if let navController = self as? UINavigationController{
      return navController.visibleViewController ?? self
    }
    return self
  }
}

