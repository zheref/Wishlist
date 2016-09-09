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
    var displayingWishes: [WishModel] = []
    weak var presenter: WishesListPresenterProtocol?
    var lastChosenWish: WishModel?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let module = Injector.shared.getWishesList(withView: self)
        presenter = module.presenter as? WishesListPresenterProtocol
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = view.bounds.size.width
        let searchBar = UISearchBar(frame: CGRectMake(0, 0, width, 44))
        searchBar.searchBarStyle = .Minimal
        searchBar.delegate = self
        searchBar.placeholder = "Type here to filter"
        tableView.tableHeaderView = searchBar
        
        setupTableViewSearchOffset()
    }
    
    
    override func viewWillAppear(animated: Bool) {
        presenter?.getWishes({ [weak self] (wishes) in
            if let this = self {
                this.loadedWishes = wishes
                this.displayingWishes = this.loadedWishes
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
        return displayingWishes.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(KReuseIdentifiers.WishCell,
                                                               forIndexPath: indexPath) as! WishTableViewCell
        cell.apply(displayingWishes[indexPath.row])
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        lastChosenWish = displayingWishes[indexPath.row]
        performSegueWithIdentifier(KSegues.ListToDetail, sender: self)
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == KSegues.ListToDetail {
            if var controller = segue.destinationViewController as? WishDetailViewControllerProtocol {
                controller.model = lastChosenWish
            }
        }
    }
    
    
    private func setupTableViewSearchOffset() {
        var contentOffset = tableView.contentOffset
        contentOffset.y += CGRectGetHeight(tableView.tableHeaderView!.frame)
        tableView.contentOffset = contentOffset
    }
    
    
    private func search(withPrefix prefix: String) {
        if prefix.isEmpty {
            displayingWishes = loadedWishes
        } else {
            displayingWishes = loadedWishes.filter({ (wishModel) -> Bool in
                wishModel.name.lowercaseString.hasPrefix(prefix.lowercaseString)
            })
        }
        
        tableView.reloadData()
    }
    
}


extension WishesListViewController : UISearchBarDelegate {
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        BatLog.shared.verbose(searchText)
        search(withPrefix: searchText)
    }
    
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        BatLog.shared.verbose("Cancel tapped")
    }
    
}