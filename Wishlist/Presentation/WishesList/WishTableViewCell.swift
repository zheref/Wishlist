//
//  WishTableViewCell.swift
//  Wishlist
//
//  Created by Sergio Daniel Leztark on 9/8/16.
//  Copyright © 2016 zheref. All rights reserved.
//

import UIKit

class WishTableViewCell : UITableViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pictureLabel: UIImageView!
    
    
    func apply(model: WishModel) {
        nameLabel.text = model.name
        
        if let longDesc = model.longDescription {
            descriptionLabel.text = longDesc
        } else {
            descriptionLabel.text = ""
        }
        
        handleImageResourceUrl(model.imageResourceName)
    }
    
    
    private func handleImageResourceUrl(resourceName: String?) {
        if let resource = resourceName {
            if resource.hasPrefix("http://") {
                BATTP.getImage(resource, by: { (data) in
                    BatUI.run({
                        self.pictureLabel.image = UIImage(data: data)
                    })
                }, orFailWith: { (str) in
                    BatLog.shared.error(str)
                })
            }
        }
    }
    
    
}
