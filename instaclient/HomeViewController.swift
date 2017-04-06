//
//  HomeViewController.swift
//  instaclient
//
//  Created by  Alex Sumak on 3/30/17.
//  Copyright © 2017  Alex Sumak. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

  
  @IBOutlet weak var tableView: UITableView!
  
  var posts : [PFObject]?
  let vc = UIImagePickerController()
  
  @IBOutlet weak var instaImage: UIImageView!
  
  
    override func viewDidLoad() {
        super.viewDidLoad()

      tableView.delegate = self
      tableView.dataSource = self
      self.tableView.reloadData()
   
        // Do any additional setup after loading the view.
    }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return posts?.count ?? 0
    
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "instaCell", for: indexPath) as! InstaCellTableViewCell
    let instagramPost = posts![indexPath.row]
    
    cell.instagramPost = instagramPost
    
    cell.selectionStyle = UITableViewCellSelectionStyle.none
    
    return cell
  }
  
  @IBAction func onLogoutButton(_ sender: Any) {
    PFUser.logOut()
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "userDidLogoutNotification"), object: nil)
  }
  
  func showPosts() {
    let query = PFQuery(className: "Post")
    query.order(byDescending: "createdAt")
    query.limit = 20
    query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
      if let posts = posts {
        print(posts)
        self.posts = posts
        self.tableView.reloadData()
      } else {
        print("Posts failed to fetch")
        print(error?.localizedDescription)
      }
    }
  }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  @IBAction func oncaptureButton(_ sender: Any) {
    vc.delegate = self
    vc.allowsEditing = true
    vc.sourceType = UIImagePickerControllerSourceType.camera
    
    self.present(vc, animated: true, completion: nil)
  }
  
  func imagePickerController(picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    
    let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
    let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage

    
    dismiss(animated: true, completion: nil)
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
  
  func resize(image: UIImage, newSize: CGSize) -> UIImage {
    let resizeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
      
    resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
    resizeImageView.image = image
    
    UIGraphicsBeginImageContext(resizeImageView.frame.size)
    resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage!
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


