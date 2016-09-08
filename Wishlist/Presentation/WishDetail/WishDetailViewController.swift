//
//  WishDetailViewController.swift
//  Wishlist
//
//  Created by Sergio Daniel Lozano on 9/8/16.
//  Copyright © 2016 zheref. All rights reserved.
//

import UIKit


protocol WishDetailViewControllerProtocol {
    
    var model: WishModel? { get set }
    
}


class WishDetailViewController : UIViewController, WishDetailViewControllerProtocol {
    
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var model: WishModel?
    
    override func viewWillAppear(animated: Bool) {
        if let model = model {
            let currentLocale = NSLocale.autoupdatingCurrentLocale()
            
            nameLabel.text = model.name
            descriptionLabel.text = model.longDescription == nil ? "No description available." : model.longDescription!
            priceLabel.text = model.price == nil ? "$???" : "$\(model.price!.descriptionWithLocale(currentLocale))"
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = .LongStyle
            
            deadlineLabel.text = model.deadline == nil ? "No deadline." : dateFormatter.stringFromDate(model.deadline!)
            
            handleImageResourceUrl(model.imageResourceName)
        }
        
        super.viewWillAppear(animated)
    }
    
    
    private func handleImageResourceUrl(resourceName: String?) {
        if let resource = resourceName {
            if resource.hasPrefix("http://") {
                BATTP.getImage(resource, by: { (data) in
                    self.pictureImageView.image = UIImage(data: data)
                }, orFailWith: { (str) in
                    BatLog.shared.error(str)
                })
            }
        }
    }
    
}