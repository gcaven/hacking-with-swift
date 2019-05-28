//
//  ViewController.swift
//  StormViewer
//
//  Created by Geoffrey Caven on 2019-05-22.
//  Copyright © 2019 Geoffrey Caven. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
  
  var pictures = [String]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Storm Viewer"
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(recommendApp))
    
    let fm = FileManager.default
    let path = Bundle.main.resourcePath!
    let items = try! fm.contentsOfDirectory(atPath: path)
     
    for item in items {
      if item.hasPrefix("nssl") {
        pictures.append(item)
      }
    }
    
    pictures.sort()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return pictures.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
    cell.textLabel?.text = pictures[indexPath.row]
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
      vc.selectedImage = pictures[indexPath.row]
      vc.imageIndex = indexPath.row
      vc.totalImageCount = pictures.count
      navigationController?.pushViewController(vc, animated: true)
    }
  }
  
  @objc func recommendApp() {
    let vc = UIActivityViewController(activityItems: ["Try out stormviewer, the app that lets you view storms!"], applicationActivities: [])
    vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
    present(vc, animated: true)
  }
}

