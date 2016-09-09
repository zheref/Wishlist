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
    
    // MARK: - UI
    
    var searchBar: UISearchBar!
    
    // MARK: - INSTANCE MEMBERS
    
    var loadedWishes: [WishModel] = []
    weak var presenter: WishesListPresenterProtocol?
    var lastChosenWish: WishModel?
    
    var lastTypedKeyword: String {
        guard let text = searchBar.text else {
            return ""
        }
        
        return text
    }
    
    lazy var lastSortingMode: SortingMode = {
        return .Ascendent
    }()
    
    // MARK: - INITIALIZERS
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let module = Injector.shared.getWishesList(withView: self)
        presenter = module.presenter as? WishesListPresenterProtocol
    }
    
    // MARK: - LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupTableViewSearchOffset()
    }
    
    
    override func viewWillAppear(animated: Bool) {
        setupNavigationBar()
        loadData()
        
        super.viewWillAppear(animated)
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == KSegues.ListToDetail {
            if var controller = segue.destinationViewController as? WishDetailViewControllerProtocol {
                controller.model = lastChosenWish
            }
        }
    }
    
    
    private func loadData() {
        presenter?.getWishes(prefixing: lastTypedKeyword, sorting: lastSortingMode, returner: { [weak self] (wishes) in
            guard let this = self else {
                BatLog.shared.severe("\(GenericError.WeakSelfNotAvailable)")
                return
            }
            
            this.loadedWishes = wishes
            this.tableView.reloadData()
        })
    }
    
    
    private func setupSearchBar() {
        let width = view.bounds.size.width
        searchBar = UISearchBar(frame: CGRectMake(0, 0, width, 44))
        searchBar.searchBarStyle = .Minimal
        searchBar.delegate = self
        searchBar.placeholder = KCopies.SearchPlaceholder
        tableView.tableHeaderView = searchBar
    }
    
    
    private func setupTableViewSearchOffset() {
        var contentOffset = tableView.contentOffset
        contentOffset.y += CGRectGetHeight(tableView.tableHeaderView!.frame)
        tableView.contentOffset = contentOffset
    }
    
    
    private func setupNavigationBar() {
        let navBar = self.navigationController?.navigationBar
        let image = UIImage(named: "logo")
        navBar?.setBackgroundImage(image, forBarMetrics: .Default)
        navBar?.translucent = false
        title = ""
    }
    
    
    private func toggleSort() {
        switch lastSortingMode {
        case .Ascendent:
            lastSortingMode = .Descendent
        case .Descendent:
            lastSortingMode = .Ascendent
        }
        
        loadData()
    }
    
    // MARK: - ACTIONS
    
    @IBAction func onSortButtonActioned(sender: UIBarButtonItem) {
        toggleSort()
    }
    
    
}

// MARK: - UITABLEVIEW DATASOURCE AND DELEGATE IMPLEMENTATION

extension WishesListViewController {
    
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
        lastChosenWish = loadedWishes[indexPath.row]
        performSegueWithIdentifier(KSegues.ListToDetail, sender: self)
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
}

// MARK: - UISEARCHBAR DELEGATE IMPLEMENTATION

extension WishesListViewController : UISearchBarDelegate {
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        loadData()
    }
    
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        BatLog.shared.verbose("Cancel tapped")
    }
    
}