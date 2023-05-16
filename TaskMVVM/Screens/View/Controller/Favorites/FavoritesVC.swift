//
//  FavoritesVC.swift
//  TaskMVVM
//
//  Created by EZAZ AHAMD on 28/01/23.
//

import UIKit

class FavoritesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var arrData = [Json_album_model]()
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "AlbumCell", bundle: nil), forCellReuseIdentifier: "AlbumCell")
        
      
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
        loadData()
        
        
    }
  

    func loadData() {
       self.arrData = RealmHelper.getObjects()
       tableView.reloadData()
   }
    
}


extension FavoritesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"AlbumCell", for: indexPath) as? AlbumCell else { return UITableViewCell()}
        
        cell.album_Data = arrData[indexPath.row]
        cell.isReload = { isRe in
            self.loadData()
        }
        return cell
    }
    
    
}





