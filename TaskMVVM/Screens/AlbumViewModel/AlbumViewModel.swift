//
//  AlbumViewModel.swift
//  TaskMVVM
//
//  Created by EZAZ AHAMD on 28/01/23.
//

import Foundation


final class AlbumViewModel {
    var albumData = [Json_album_model]()
    var currentPage = 1
    var totalPages = 10
    
    var searchText = "" {
           didSet {
               search()
           }
       }
    var searchResults = [Json_album_model]() {
        didSet {
            self.eventHandler?(.dataLoaded)
        }
    }
    
   
    var eventHandler: ((_ event :Event) -> Void)?
    
    
    func fetchDataFromAPI( page: Int){
        let url = "https://jsonplaceholder.typicode.com/photos?albumId=\(page)"
        print("URL",url)
        APIManager.shared.request(strUrl: url, modelType: [Json_album_model].self) { response in
            switch response {
             case .success(let album_data):
                self.albumData += album_data
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
    
    
   
       
     
       
       func search() {
           // perform search logic here and update searchResults array
           guard !searchText.isEmpty else{
               searchResults = albumData
               
               return
           }
           
           searchResults = albumData.filter { ($0.title?.lowercased().contains(searchText.lowercased()))!}
       
       }
    
    
    
    
}


extension AlbumViewModel {
    enum Event {
        case dataLoaded
        case error(Error?)
       
    }
}
