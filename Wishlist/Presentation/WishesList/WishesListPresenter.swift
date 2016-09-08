//
//  WishesListPresenter.swift
//  Wishlist
//
//  Created by Sergio Daniel Leztark on 9/8/16.
//  Copyright © 2016 zheref. All rights reserved.
//

import Foundation


protocol WishesListPresenterProtocol : BatPresenter {
    
    init(withView view: WishesListViewControllerProtocol, andRepository dataManager: WishesDataManagerProtocol)
    
    func getWishes(returner: ([WishModel]))
    
}


class WishesListPresenter : WishesListPresenterProtocol {
    
    required init(withView view: WishesListViewControllerProtocol,
                  andRepository dataManager: WishesDataManagerProtocol) {
        
    }
    
    
    func getWishes(returner: ([WishModel])) {
        
    }
    
}