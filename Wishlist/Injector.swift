//
//  Injector.swift
//  Wishlist
//
//  Created by Sergio Daniel Leztark on 9/8/16.
//  Copyright © 2016 zheref. All rights reserved.
//

import Foundation

class Injector {
    
    private init() {}
    
    
    static var shared: Injector = {
        return Injector()
    }()
    
    
    private lazy var wishesList: Module = {
        
        let module = Module()
        
        return module
        
    }()
    
    
    func getWishesList(withView view: BatView) -> Module {
        let dataManager = WishesDataManager()
        
        wishesList.view = view
        
        let presenter = WishesListPresenter(
            withView: wishesList.view as! WishesListViewControllerProtocol,
            andRepository: dataManager
        )
        
        wishesList.presenter = presenter
        
        return wishesList
    }
    
}


class Module {
    
    var view: BatView!
    var presenter: BatPresenter!
    
}


protocol BatView : class {
    func show(error: ErrorType)
}


protocol BatPresenter : class {
    
}