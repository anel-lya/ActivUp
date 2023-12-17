//
//  TestViewController.swift
//  ActivUp
//
//  Created by Anel Rustamova on 14.12.2023.
//

import UIKit

class TestViewController: UIViewController, UITabBarDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchResultsUpdating {
    
   
    @IBOutlet weak var table: UITableView!
    
    let sc = UISearchController()
    let list = ["123", "456", "234", "890", "678", "026"]
    var filteredList : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        sc.searchResultsUpdater = self
        sc.searchBar.enablesReturnKeyAutomatically = false
        sc.searchBar.returnKeyType = UIReturnKeyType.done
        
        definesPresentationContext = true
        navigationItem.searchController = sc
        navigationItem.hidesSearchBarWhenScrolling = false
        sc.searchBar.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (sc.isActive){
            return filteredList.count
        }
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cel = tableView.dequeueReusableCell(withIdentifier: "test") as! TestTableViewCell
        var e : String = ""
        if (sc.isActive){
            e = filteredList[indexPath.row]
        }
        else {
            e = list[indexPath.row]
        }
        cel.lbl.text = e
        return cel
    }
    

    
    func updateSearchResults(for searchController: UISearchController) {
        
        let serb = searchController.searchBar
        let serT = serb.text!
                
        filteredList = list.filter
        {
            shape in
            let scopeMatch = shape.lowercased().contains(serT.lowercased())
            
            if(sc.searchBar.text != "")
            {
                let searchTextMatch = shape.lowercased().contains(serT.lowercased())
                return scopeMatch && searchTextMatch
            }
            else
            {
                return scopeMatch
            }
            
        }
        table.reloadData()
    }

    
}
