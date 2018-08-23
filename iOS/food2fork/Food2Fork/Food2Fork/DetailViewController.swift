//
//  DetailViewController.swift
//  Food2Fork
//
//  Created by Natan Facchin on 07/02/17.
//  Copyright © 2017 NFS Industries. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import SafariServices

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var recipeImageView: UIImageView!

    @IBOutlet weak var ingredientsLabel: UILabel!

    @IBOutlet weak var ingredientsTableView: UITableView!

    func configureView() {
        // Update the user interface for the detail item.
        
        if let recipe = self.detailItem {
            self.title = recipe.title
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        self.loadRecipeImage()
        self.requestRecipeDetailsFromWebService()
        
        ingredientsTableView.delegate      =   self
        ingredientsTableView.dataSource    =   self

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.detailItem?.ingredients != nil) {
            return (self.detailItem?.ingredients.count)!
        } else {
            return 0
        }
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "Cell")
        cell.textLabel?.text = self.detailItem?.ingredients[indexPath.row]

        return cell
    }
    
    @IBAction func viewInstructions(_ sender: Any) {
        //UIApplication.shared.openURL(URL(string: (self.detailItem?.f2fUrl)!)!)
        let svc = SFSafariViewController(url: URL(string: (self.detailItem?.f2fUrl)!)!)
        present(svc, animated: true, completion: nil)
    }
    
    
    @IBAction func viewOriginal(_ sender: Any) {
        //UIApplication.shared.openURL(URL(string: (self.detailItem?.sourceURL)!)!)
        let svc = SFSafariViewController(url: URL(string: (self.detailItem?.sourceURL)!)!)
        present(svc, animated: true, completion: nil)
    }
    
    func loadRecipeImage() {
        let imageURL = URL(string: (self.detailItem?.photoURL)!)
        recipeImageView.kf.setImage(with: imageURL, placeholder: nil, options: [.transition(ImageTransition.fade(1))], progressBlock: { receivedSize, totalSize in
            //print("\(indexPath.row + 1): \(receivedSize)/\(totalSize)")
        },
                                    completionHandler: { image, error, cacheType, imageURL in
                                        //nothing here
        })
    }

    func requestRecipeDetailsFromWebService() {
        let requestURLString = Constants.URLS.recipeURL + Constants.Defaults.recipeIdQuery + (self.detailItem?.recipeId)!
        Alamofire.request(requestURLString).responseJSON { response in
            debugPrint(response)
            if let json = response.result.value {
                //debugPrint("JSON: \(json)")
                self.detailItem = Recipe(jsonWithDetailedRecipe: json)
                self.ingredientsTableView.reloadData()

            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: Recipe? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }


}

