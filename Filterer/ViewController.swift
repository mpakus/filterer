//
//  ViewController.swift
//  Filterer
//
//  Created by MpaK on 1/3/17.
//  Copyright © 2017 aomega. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var toggleImage: UIButton!
  @IBOutlet var secondaryMenu: UIView!
  
//  @IBAction func onImageToggle(_ sender: UIButton) {
//    let image = UIImage(named: "sample")
//    
//    imageView.image = image
//    toggleImage.isSelected = true
//  }
  @IBOutlet weak var filterButton: UIButton!
  @IBOutlet weak var bottomMenu: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    secondaryMenu.backgroundColor = UIColor.white.withAlphaComponent(0.8)
//    toggleImage.setTitle("Applied", for: .selected)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func onFilter(_ sender: UIButton) {
    if(sender.isSelected){
      hideSecondaryMenu()
      sender.isSelected = false
    }else{
      showSecodaryMenu()
      sender.isSelected = true
    }
  }
  
  func showSecodaryMenu(){
    view.addSubview(secondaryMenu)
    
    secondaryMenu.translatesAutoresizingMaskIntoConstraints = false
    
    let bottomConstraint = secondaryMenu.bottomAnchor.constraint(equalTo: bottomMenu.topAnchor)
    let leftContraint = secondaryMenu.leftAnchor.constraint(equalTo: view.leftAnchor)
    let rightContraint = secondaryMenu.rightAnchor.constraint(equalTo: view.rightAnchor)
    
    let heightConstraint = secondaryMenu.heightAnchor.constraint(equalToConstant: 44)
    
    NSLayoutConstraint.activate([bottomConstraint, leftContraint, rightContraint, heightConstraint])
    view.layoutIfNeeded()
  }
  
  func hideSecondaryMenu(){
    secondaryMenu.removeFromSuperview()
  }
}

