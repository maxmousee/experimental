//
//  MasterViewController.swift
//  Food2Fork
//
//  Created by Natan Facchin on 07/02/17.
//  Copyright © 2017 NFS Industries. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire

class MasterViewController: UITableViewController, UISearchControllerDelegate {

    var detailViewController: DetailViewController? = nil
    var recipes = [Recipe]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchController = UISearchController(searchResultsController: self)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        self.tableView.setEditing(false, animated: false)
        requestRecipesFromWebService()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segues.detailRecipe {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let recipe = recipes[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = recipe
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
 
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let recipe = recipes[indexPath.row] 
        cell.textLabel!.text = recipe.title
        /*
        let imageURL = URL(string: recipe.photoURL!)
        cell.imageView?.kf.setImage(with: imageURL, placeholder: nil, options: nil, progressBlock: { receivedSize, totalSize in
            //print("\(indexPath.row + 1): \(receivedSize)/\(totalSize)")
        },
                                    completionHandler: { image, error, cacheType, imageURL in
                                        //self.tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
        })
        */
 
        
        if let URL = URL(string: recipe.photoURL), let data = try? Data(contentsOf: URL) {
            cell.imageView?.image = UIImage(data: data)
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    func requestRecipesFromWebService() {
        let requestURLString = Constants.URLS.searchURL
        Alamofire.request(requestURLString).responseJSON { response in
            debugPrint(response)
            if let json = response.result.value {
                //debugPrint("JSON: \(json)")
                self.recipes = getRecipeArrayFromQuery(jsonWithObjectRoot: json)
                self.tableView.reloadData()
            }
        }
    }
    
    func requestRecipesFromWebService(withQuery: String) {
        let requestURLString = Constants.URLS.searchURL + Constants.URLS.searchURL + withQuery
        debugPrint("Search URL: \(requestURLString)")
        Alamofire.request(requestURLString).responseJSON { response in
            debugPrint(response)
            if let json = response.result.value {
                debugPrint("SEARCH results: \(json)")
                self.recipes = getRecipeArrayFromQuery(jsonWithObjectRoot: json)
                self.tableView.reloadData()
            }
        }
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        requestRecipesFromWebService(withQuery: searchText);
        tableView.reloadData()
    }
}

extension MasterViewController: UISearchResultsUpdating {
    @available(iOS 8.0, *)
    public func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}

