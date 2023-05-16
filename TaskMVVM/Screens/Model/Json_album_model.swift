

import Foundation
import RealmSwift

class Json_album_model : Object, Codable {
    @objc  dynamic let albumId : Int = Int()
    @objc dynamic var id : Int = 0
    @objc dynamic var title : String? = String()
    @objc dynamic var url : String? = String()
    @objc dynamic var thumbnailUrl : String? = String()
    override class func primaryKey() -> String? {
        return "id"
    }
    
	enum CodingKeys: String, CodingKey {

		case albumId = "albumId"
		case id = "id"
		case title = "title"
		case url = "url"
		case thumbnailUrl = "thumbnailUrl"
	}

//      init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//		albumId = try values.decodeIfPresent(Int.self, forKey: .albumId)
//		id = try values.decodeIfPresent(Int.self, forKey: .id)
//		title = try values.decodeIfPresent(String.self, forKey: .title)
//		url = try values.decodeIfPresent(String.self, forKey: .url)
//		thumbnailUrl = try values.decodeIfPresent(String.self, forKey: .thumbnailUrl)
//	}

}


