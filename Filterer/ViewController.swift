//
//  ViewController.swift
//  Filterer
//
//  Created by MpaK on 1/3/17.
//  Copyright © 2017 aomega. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

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
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var toggleImage: UIButton!
  @IBOutlet var secondaryMenu: UIView!
  @IBOutlet weak var filterButton: UIButton!
  @IBOutlet weak var bottomMenu: UIView!
  
//  @IBAction func onImageToggle(_ sender: UIButton) {
//    let image = UIImage(named: "sample")
//    
//    imageView.image = image
//    toggleImage.isSelected = true
//  }
  
  @IBAction func onNewPhoto(_ sender: Any) {
    let actionSheet = UIAlertController(
      title: "New Photo",
      message: nil,
      preferredStyle: .actionSheet
    )

    actionSheet.addAction(
      UIAlertAction(
        title: "Camera",
        style: .default,
        handler: { action in self.showCamera() }
      )
    )
    
    actionSheet.addAction(
      UIAlertAction(
        title: "Album",
        style: .default,
        handler: { action in self.showAlbum() }
      )
    )
    
    actionSheet.addAction(
      UIAlertAction(
        title: "Cancel",
        style: .cancel,
        handler: nil
      )
    )
    
    self.present(actionSheet, animated: true, completion: nil)
  }
  
  @IBAction func onShare(_ sender: Any) {
    let activityController = UIActivityViewController(
      activityItems: [imageView.image!],
      applicationActivities: nil
    )
    
    present(activityController, animated: true, completion: nil)
  }
  
  @IBAction func onFilterBrightness(_ sender: Any) {
    applyFilter(BrightnessFilter(["level": "150"]))
  }
  
  
  @IBAction func onFilterContrast(_ sender: Any) {
    applyFilter(ContrastFilter(["level": "255"]))
  }
  
  @IBAction func onFilterGray(_ sender: Any) {
    applyFilter(GrayscaleFilter())
  }
  
  @IBAction func onFilterInvert(_ sender: Any) {
    applyFilter(InvertFilter())
  }
  
  @IBAction func onFilterOpacity(_ sender: Any) {
    applyFilter(OpacityFilter(["level": "510"]))
  }
  
  // Private methods
  
  func applyFilter(_ filter: Filter){
    let rgbaImage = RGBAImage(image: imageView.image!)
    imageView.image = filter.run(rgbaImage!).toUIImage()!
  }
  
  func showCamera(){
    let cameraPicker = UIImagePickerController()
    cameraPicker.delegate = self
    cameraPicker.sourceType = .camera
  
    present(cameraPicker, animated: true, completion: nil)
  }
  
  func showAlbum(){
    let cameraPicker = UIImagePickerController()
    cameraPicker.delegate = self
    cameraPicker.sourceType = .photoLibrary
    
    present(cameraPicker, animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
      imageView.image = image
    }
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true, completion: nil)
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
    
    secondaryMenu.alpha = 0
    UIView.animate(withDuration: 0.5, animations: { self.secondaryMenu.alpha = 1.0 })
  }
  
  func hideSecondaryMenu(){
    UIView.animate(
      withDuration: 0.5,
      animations: { self.secondaryMenu.alpha = 0 },
      completion: {
        completed in
        if completed { self.secondaryMenu.removeFromSuperview() }
      }
    )
  }
  
}

