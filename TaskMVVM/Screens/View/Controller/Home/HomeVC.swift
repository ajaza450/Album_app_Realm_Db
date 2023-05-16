//
//  ViewController.swift
//  TaskMVVM
//
//  Created by EZAZ AHAMD on 28/01/23.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
     var album_vm =  AlbumViewModel()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
       configuration()
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

}

extension HomeVC {

    func configuration() {
        tableView.register(UINib(nibName: "AlbumCell", bundle: nil), forCellReuseIdentifier: "AlbumCell")
        searchBar.delegate = self
        initViewModel()
        observeEvent()
    }

    func initViewModel() {
        album_vm.fetchDataFromAPI(page: album_vm.currentPage)
    }
    
    
    func observeEvent() {
        album_vm.eventHandler = { [unowned self] event in
          //  guard let self  else { return }
            switch event {
            case .dataLoaded:
                print("Data loaded...")
                DispatchQueue.main.async {
                    // UI Main works well
                    self.tableView.reloadData()
                }
            case .error(let error):
                print(error)
           
            }
        }
    }

}


extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.searchBar.isSearchResultsButtonSelected {
            return album_vm.searchResults.count
        }else{
        return album_vm.albumData.count
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"AlbumCell", for: indexPath) as? AlbumCell else { return UITableViewCell()}
        if self.searchBar.isSearchResultsButtonSelected {
            cell.album_Data = album_vm.searchResults[indexPath.row]
        }else{
            
            cell.album_Data = album_vm.albumData[indexPath.row]
        }
        
        return cell
    }
    
    
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == album_vm.albumData.count - 1 && album_vm.totalPages > album_vm.currentPage && self.searchBar.isSearchResultsButtonSelected == false{
            album_vm.currentPage += 1
            album_vm.fetchDataFromAPI(page: album_vm.currentPage)
        }
        
    }
    
    
}


extension HomeVC:UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar){
        self.searchBar.isSearchResultsButtonSelected = true
        album_vm.searchResults = album_vm.albumData
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar){
        if searchBar.text!.isEmpty {
            self.searchBar.isSearchResultsButtonSelected = false
        }else{
            self.searchBar.isSearchResultsButtonSelected = true
        }
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchText = searchBar.text else { return }
        album_vm.searchText = searchText
        print("searchText\(searchText)")
        
    }
    
    
}



extension UITableView {
    func lastIndexpath() -> IndexPath {
        let section = max(numberOfSections - 1, 0)
        let row = max(numberOfRows(inSection: section) - 1, 0)
        
        return IndexPath(row: row, section: section)
    }
}
