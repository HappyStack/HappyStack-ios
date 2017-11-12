//
//  StackVC.swift
//  HappyStack
//
//  Created by Sacha DSO on 10/11/2017.
//  Copyright © 2017 HappyStack. All rights reserved.
//

import UIKit

class StackVC: UITableViewController, ItemVCDelegate {
    
    let stack: Stack
    var items: [Item] { return stack.items }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(stack: Stack) {
        self.stack = stack
        super.init(style: .plain)
        title = "My Stack"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "...", style: .plain, target: self, action: #selector(showMore))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(addNutrient))
        tableView.register( ItemCell.self, forCellReuseIdentifier: ItemCell.reuseIdentifier)
        refresh()
    }
    
    
    var rc = UIRefreshControl()
    
    var morningItems:[Item] { return items.filter { item in noon.compare(item.time) == .orderedDescending } }
    var dayItems:[Item] { return items.filter { i in
        !morningItems.contains(where: { $0.name == i.name })
            && !eveningItems.contains(where: { $0.name == i.name })
        }
    }
    var eveningItems:[Item] { return items.filter { item in sixPm.compare(item.time) == .orderedAscending } }
    
    var noon:Date = {
        var d = Date()
        let calendar = Calendar.current
        var ba = calendar.dateComponents([.hour, .minute], from: d)
        ba.hour = 12
        d = calendar.date(from: ba)!
        return d
    }()
    
    var sixPm:Date = {
        var d = Date()
        let calendar = Calendar.current
        var ba = calendar.dateComponents([.hour, .minute], from: d)
        ba.hour = 17
        d = calendar.date(from: ba)!
        return d
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        rc.addTarget(self, action: #selector(StackVC.refresh), for: .valueChanged)
        tableView.addSubview(rc)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
    }
    
    @objc
    func refresh() {
        stack.fetch().then {
            self.rc.endRefreshing()
            
            self.stack.items.sort(by:{ (a, b) -> Bool in
                
                let calendar = Calendar.current
                let x:Set<Calendar.Component> = [.hour, .minute]
                
                let ca = calendar.dateComponents(x, from: a.time)
                let atime = calendar.date(from: ca)!
                
                let ba = calendar.dateComponents(x, from: b.time)
                let btime = calendar.date(from:ba)!
                
                return atime.compare(btime) == .orderedAscending
            })
            self.tableView.reloadData()
            self.scheduleNotification()
        }
    }
    
    func scheduleNotification() {
        UIApplication.shared.cancelAllLocalNotifications()
        for i in items {
            let n = UILocalNotification()
            n.fireDate = i.time
            let name = i.name
            n.alertBody = "Hey Kiddo it's time to take your \(name) !"
            n.applicationIconBadgeNumber = 1
            n.repeatInterval = .day
            UIApplication.shared.scheduleLocalNotification(n)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //            if let _ = User.current {
        //                print("Connected")
        //            } else {
        //                let logInController = PFLogInViewController()
        //                logInController.fields = PFLogInFields.facebook
        //                logInController.delegate = self
        //                present(logInController, animated:true, completion: nil)
        //            }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return morningItems.count
        case 1: return dayItems.count
        case 2: return eveningItems.count
        default: return 0
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Morning"
        case 1: return "Day"
        case 2: return "Evening"
        default: return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = tableView.dequeueReusableCellWithIdentifier(ItemCell.reuseIdentifier, forIndexPath: indexPath) as! ItemCell
        var item:Item!
        switch indexPath.section {
        case 0: item = morningItems[indexPath.row]
        case 1: item = dayItems[indexPath.row]
        case 2: item = eveningItems[indexPath.row]
        default:()
        }
        
        let cell = ItemCell()
        cell.render(with: item)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var item:Item!
        switch indexPath.section {
        case 0: item = morningItems[indexPath.row]
        case 1: item = dayItems[indexPath.row]
        case 2: item = eveningItems[indexPath.row]
        default:()
        }
        
        let itemVC = ItemVC(item: item)
        itemVC.delegate = self
        navigationController?.pushViewController(itemVC, animated: true)
    }
    
    @objc
    func addNutrient() {
        let itemVC = ItemVC()
        itemVC.delegate = self
        let navVC = UINavigationController(rootViewController: itemVC)
        navVC.navigationBar.isTranslucent = false
        present(navVC, animated: true, completion: nil)
    }
    
    func itemVCDidSaveOrDeleteItem() {
        refresh()
    }
    
    @objc
    func showMore() {
        navigationController?.pushViewController(MoreVC(), animated: true)
    }
}
