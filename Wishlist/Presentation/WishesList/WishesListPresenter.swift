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
    
    func getWishes(returner: ([WishModel]) -> Void)
    
}


class WishesListPresenter : WishesListPresenterProtocol {
    
    let view: WishesListViewControllerProtocol
    let repository: WishesDataManagerProtocol
    
    required init(withView view: WishesListViewControllerProtocol,
                  andRepository dataManager: WishesDataManagerProtocol) {
        self.view = view
        self.repository = dataManager
    }
    
    
    func getWishes(returner: ([WishModel]) -> Void) {
        repository.getWishes({ (models) in
            returner(models)
        }) { [unowned view] (error) in
            view.show(error)
        }
    }
    
}