
import Foundation
 

public class StampCards_Base {
	public var status : Bool?
	public var message : String?
	public var data : [StampCardsData]?


    public class func modelsFromDictionaryArray(array:NSArray) -> [StampCards_Base]
    {
        var models:[StampCards_Base] = []
        for item in array
        {
            models.append(StampCards_Base(dictionary: item as! NSDictionary)!)
        }
        return models
    }

	required public init?(dictionary: NSDictionary) {

		status = dictionary["status"] as? Bool
		message = dictionary["message"] as? String
        if (dictionary["data"] != nil) { data = StampCardsData.modelsFromDictionaryArray(array: dictionary["data"] as! NSArray) }
	}


	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.status, forKey: "status")
		dictionary.setValue(self.message, forKey: "message")

		return dictionary
	}

}

public class ProductData{
    public var name : String?
    public var sku : String?
    public var voucherId : Int?
    public var voucherPlusId : String?
    public var voucherAvailType : String?
    public var image : String?
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [ProductData]
    {
        var models:[ProductData] = []
        for item in array
        {
            models.append(ProductData(dictionary: item as! NSDictionary)!)
        }
        return models
    }


    required public init?(dictionary: NSDictionary) {

        name = dictionary["cat_product_name"] as? String
        sku = dictionary["prd_sku"] as? String
        voucherId = dictionary["voucher_avail_type_id"] as? Int
        image = dictionary["image"] as? String
        voucherPlusId = dictionary["voucher_plu_ids"] as? String
        voucherAvailType = dictionary["voucher_avail_type"] as? String
//        points = dictionary["points"] as? Int
    }

        
    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.name, forKey: "cat_product_name")
        dictionary.setValue(self.sku, forKey: "prd_sku")
        dictionary.setValue(self.voucherId, forKey: "voucher_avail_type_id")
        dictionary.setValue(self.image, forKey: "image")
        dictionary.setValue(self.voucherPlusId, forKey: "voucher_plu_ids")
        dictionary.setValue(self.voucherAvailType, forKey: "voucher_avail_type")
//        dictionary.setValue(self.points, forKey: "points")

        return dictionary
    }
}
public class StampCardsData {
    public var name : String?
    public var description : String?
    public var punch_card_count : Int? = 0
    public var image : String?
    public var amount : Int?
    public var quantity : Int?
     public var points : Int?
    public var proData : [ProductData]!
    public class func modelsFromDictionaryArray(array:NSArray) -> [StampCardsData]
    {
        var models:[StampCardsData] = []
        for item in array
        {
            models.append(StampCardsData(dictionary: item as! NSDictionary)!)
        }
        return models
    }


    required public init?(dictionary: NSDictionary) {

        name = dictionary["name"] as? String
        description = dictionary["description"] as? String
        punch_card_count = dictionary["punch_card_count"] as? Int
        image = dictionary["image"] as? String
        amount = dictionary["amount"] as? Int
        quantity = dictionary["quantity"] as? Int
        points = dictionary["points"] as? Int
        if (dictionary["product_data"] != nil) { proData = ProductData.modelsFromDictionaryArray(array: dictionary["product_data"] as! NSArray) }
    }

        
    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.name, forKey: "name")
        dictionary.setValue(self.description, forKey: "description")
        dictionary.setValue(self.punch_card_count, forKey: "punch_card_count")
        dictionary.setValue(self.image, forKey: "image")
        dictionary.setValue(self.amount, forKey: "amount")
        dictionary.setValue(self.quantity, forKey: "quantity")
        dictionary.setValue(self.points, forKey: "points")

        return dictionary
    }
}
