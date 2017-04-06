//
//  UploadPhotoViewController.swift
//  instaclient
//
//  Created by  Alex Sumak on 4/1/17.
//  Copyright © 2017  Alex Sumak. All rights reserved.
//

import UIKit
import Parse
import ParseUI


class UploadPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let vc = UIImagePickerController()
  
  @IBOutlet weak var pictureChooser: UIImageView!
  
  @IBOutlet weak var captionStuff: UITextField!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
    // Create Parse object PFObject
    let post = PFObject(className: "Post")
    
    // Add relevant fields to the object
    post["media"] = getPFFileFromImage(image: image) // PFFile column type
    post["author"] = PFUser.current() // Pointer column type that points to PFUser
    post["caption"] = caption
    post["likesCount"] = 0
    post["commentsCount"] = 0
    
    
    
    // Save object (following function will save the object in Parse asynchronously)
    post.saveInBackground(block: completion)
  }
  
  func getPFFileFromImage(image: UIImage?) -> PFFile? {
    // check if image is not nil
    if let image = image {
      // get image data and check if that is not nil
      if let imageData = UIImagePNGRepresentation(image) {
        return PFFile(name: "image.png", data: imageData)
      }
    }
    return nil
  }
  
  @IBAction func onuploadButton(_ sender: Any) {
    vc.delegate = self
    vc.allowsEditing = true
    vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
    
    self.present(vc, animated: true, completion: nil)
  }
  @IBAction func postButton(_ sender: Any) {
    postUserImage(image: pictureChooser.image, withCaption: self.captionStuff.text, withCompletion: nil)
  }
  
  
  private func imagePickerController(picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    
    let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
    let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
    
    pictureChooser.image = editedImage
    
    
    
    
    
    dismiss(animated: true, completion: nil)
  }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
