//
//  DetailViewController.swift
//  StormViewer
//
//  Created by Geoffrey Caven on 2019-05-22.
//  Copyright © 2019 Geoffrey Caven. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

  @IBOutlet var imageView: UIImageView!
  
  var selectedImage: String?
  var imageIndex = 0
  var totalImageCount = 1
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Picture \(imageIndex + 1) of \(totalImageCount)"
    navigationItem.largeTitleDisplayMode = .never
    if let imageToLoad = selectedImage  {
      imageView.image = UIImage(named: imageToLoad)
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.hidesBarsOnTap = true
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.hidesBarsOnTap = false
  }
  
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
