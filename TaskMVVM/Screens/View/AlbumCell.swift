//
//  AlbumCell.swift
//  TaskMVVM
//
//  Created by EZAZ AHAMD on 28/01/23.
//

import UIKit
import RealmSwift

class AlbumCell: UITableViewCell {

    @IBOutlet weak var album_image:UIImageView!
    @IBOutlet weak var album_title:UILabel!
    @IBOutlet weak var album_fav_Btn:UIButton!
    
    var album_Data: Json_album_model? {
        didSet{
            loadData()
        }
    }
    var isReload :((Bool)-> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func loadData(){
        guard let album_Data = album_Data else{return}
        album_title.text = album_Data.title ?? "hello"
        album_image.setImage(with: album_Data.url ?? (album_Data.thumbnailUrl ?? ""))
        var arrData = [Json_album_model]();
        arrData = RealmHelper.getObjects()
        print("GET DATA++ ", arrData.count > 0, arrData.filter({$0.id == album_Data.id}))
        if arrData.filter({$0.id == album_Data.id}).count != 0{
            // fav
            album_fav_Btn.backgroundColor = .yellow
        } else {
           
            album_fav_Btn.backgroundColor = .gray
          
            
        }
      
       // RealmHelper.saveObject(object: album_Data)
    }
    
    
    @IBAction func clickOnFev( _ sender: UIButton){
        guard let album_Data = album_Data else{return}
        
        var arrData = [Json_album_model]()
        arrData = RealmHelper.getObjects()

        do {
            let realm = try Realm()
            try realm.write {
                if arrData.count > 0 {

                    
                    let puppies = arrData.filter { data in
                        if data.isInvalidated == false{
                            return data.id == album_Data.id
                        }else{
                            return false
                        }
                    }
                    
                // Delete the objects in the collection from the realm.
                if  puppies.count > 0 {
                    print("DELEE")
                realm.delete(puppies)
                sender.backgroundColor = .gray
                }else{
                    let copy = realm.create(Json_album_model.self, value: album_Data, update: .all)
                    realm.add(copy, update: .all)
                    sender.backgroundColor = .yellow
                }}else{
                    let copy = realm.create(Json_album_model.self, value: album_Data, update: .all)
                    realm.add(copy, update: .all)
                   // realm.add(album_Data)
                    sender.backgroundColor = .yellow
                }
               
            }
            isReload?(true)
        }catch let error{
            print("error",error)
        }
   
    }
    
}
