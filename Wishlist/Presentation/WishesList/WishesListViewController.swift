//
//  WishesListViewController.swift
//  Wishlist
//
//  Created by Sergio Daniel Leztark on 9/8/16.
//  Copyright © 2016 zheref. All rights reserved.
//

import UIKit


protocol WishesListViewControllerProtocol : BatView {
    
    
    
}


class WishesListViewController : UITableViewController, WishesListViewControllerProtocol {
    
    var loadedWishes: [WishModel] = []
    weak var presenter: WishesListPresenterProtocol?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let module = Injector.shared.getWishesList(withView: self)
        presenter = module.presenter as? WishesListPresenterProtocol
    }
    
    override func viewWillAppear(animated: Bool) {
//        tableView.delegate = self
//        tableView.dataSource = self
        
        presenter?.getWishes({ [weak self] (wishes) in
            if let this = self {
                this.loadedWishes.appendContentsOf(wishes)
                this.tableView.reloadData()
            } else {
                BatLog.shared.severe("\(GenericError.WeakSelfNotAvailable)")
            }
        })
        
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loadedWishes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(KReuseIdentifiers.WishCell,
                                                               forIndexPath: indexPath) as! WishTableViewCell
        cell.apply(loadedWishes[indexPath.row])
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //close(withCategory: self._categories[indexPath.row])
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
}