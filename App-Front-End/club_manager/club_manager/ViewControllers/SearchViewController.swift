//
//  searchViewController.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/03/25.
//

import UIKit

import UIKit

class SearchViewController: UIViewController {
    
    private var table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
       return table
    }()
   
    let searchController = UISearchController()
    
    var data = [String]()
    var filteredData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        table.dataSource = self
        table.delegate = self
        initSearchController()
        
        view.addSubview(table)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
    
    func initSearchController(){
        table.tableHeaderView = searchController.searchBar
        //Loads the view controller’s view if it has not yet been loaded.
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search .."
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        
        //ser presentation context
        self.definesPresentationContext = true
        navigationItem.searchController = searchController
        //searchController.searchBar.scopeButtonTitles = ["All", "coffee", "tea"]
        searchController.searchBar.delegate = self
    }
    
    private func setupData(){
        data.append("water")
        data.append("index")
        data.append("americano")
        data.append("latte")
        data.append("green tea")
        data.append("black tea")
        data.append("ice cream")
        data.append("lemonade")
        data.append("blue lemonade")
        data.append("vanilla latte")
    }

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !filteredData.isEmpty {
            return filteredData.count
        }
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if !filteredData.isEmpty{
            cell.textLabel?.text = filteredData[indexPath.row]
        }else {
            cell.textLabel?.text = data[indexPath.row]
        }
  
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
   
    
}

extension SearchViewController: UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate{

    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        //let scopeButton = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        //print("scopeButton ", scopeButton)
        let searchText = searchBar.text!
        filterForSearchTextAndScopeButton(searchText: searchText)
    }

    func filterForSearchTextAndScopeButton(searchText: String){
        filteredData = data.filter{
            (data: String) -> Bool in
                //let scopeMatch = (scopeButton == "All" || data.lowercased().contains(scopeButton.lowercased()))
            let searchTextMath = data.lowercased().contains(searchText.lowercased())
            return searchTextMath
        }
        table.reloadData()
        
    }
}


