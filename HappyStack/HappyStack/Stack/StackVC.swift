//
//  StackVC.swift
//  HappyStack
//
//  Created by Sacha DSO on 10/11/2017.
//  Copyright © 2017 HappyStack. All rights reserved.
//

import UIKit
import Stevia

class StackView: UIView {
    
    let background = UIImageView(image: #imageLiteral(resourceName: "BG"))
    let tableView = UITableView(frame: .zero, style: .grouped)
    let iButton = UIButton(type: UIButtonType.infoLight)
    
    convenience init() {
        self.init(frame: CGRect.zero)
        
        sv(
            background,
            tableView,
            iButton
        )
        
        background.fillContainer()
        tableView.fillHorizontally(m: 15).fillVertically()
        
        iButton.left(20).bottom(20)
        
        
        iButton.tintColor = .white
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        
        
    }
}

class StackVC: UIViewController, ItemVCDelegate, UITableViewDataSource, UITableViewDelegate {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    let stack: Stack
    var items: [Item] { return stack.items }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(stack: Stack) {
        self.stack = stack
        super.init(nibName: nil, bundle: nil)
        title = "My Stack"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "...", style: .plain, target: self, action: #selector(showMore))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(addNutrient))
        v.tableView.register(ItemCell.self, forCellReuseIdentifier: ItemCell.reuseIdentifier)
        v.tableView.dataSource = self
        v.tableView.delegate = self
        
        refresh()
    }
    
    let v = StackView()
    override func loadView() { view = v }
    
    var morningItems:[Item] { return items.filter { item in noon.compare(item.time) == .orderedDescending } }
    var dayItems:[Item] { return items.filter { i in
        !morningItems.contains(where: { $0.identifier == i.identifier })
            && !eveningItems.contains(where: { $0.identifier == i.identifier })
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

        v.tableView.rowHeight = 78
        
        let addButton = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        addButton.setTitle("Add a supplement", for: .normal)
        addButton.addTarget(self, action: #selector(addSupplement), for: .touchUpInside)
        addButton.titleLabel?.font = UIFont(name: "Lato-Bold", size: 15)
        v.tableView.tableHeaderView = addButton
        
        v.iButton.addTarget(self, action: #selector(infoTapped), for: .touchUpInside)
        
        
        v.iButton.isHidden = true
    }
    
    @objc
    func addSupplement() {
        let vc = NewSupplementVC()
        vc.didCancel = { [unowned self] in
            self.dismiss(animated: true, completion: nil)
        }
        vc.didAddSupplement = { [unowned self] in
            self.dismiss(animated: true, completion: nil)
            self.refresh()
        }
        present(vc, animated: true, completion: nil)
    }
    
    @objc
    func infoTapped() {
        let moreVC = MoreVC()
        moreVC.didClose = { [unowned self] in
            self.dismiss(animated: true, completion: nil)
        }
        let navVC = UINavigationController(rootViewController: moreVC)
        present(navVC, animated: true, completion: nil)
    }
    
    @objc
    func refresh() {
        stack.fetch().then {
            
            self.stack.items.sort(by:{ (a, b) -> Bool in
                
                let calendar = Calendar.current
                let x:Set<Calendar.Component> = [.hour, .minute]
                
                let ca = calendar.dateComponents(x, from: a.time)
                let atime = calendar.date(from: ca)!
                
                let ba = calendar.dateComponents(x, from: b.time)
                let btime = calendar.date(from:ba)!
                
                return atime.compare(btime) == .orderedAscending
            })
            self.v.tableView.reloadData()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return morningItems.count
        case 1: return dayItems.count
        case 2: return eveningItems.count
        default: return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .clear

        let round = UIView()
        header.sv(round)
        |round|.height(30).top(0)
        round.layer.cornerRadius = 8
        round.backgroundColor = .white
        
        let square = UIView()
        header.sv(square)
        |square|.height(40).bottom(0)
        square.backgroundColor = .white
        
        let label = UILabel()
        header.sv(label)
        
        let count = UILabel()
        header.sv(count)
        label.centerVertically()
        align(horizontally: |-20-label-(>=8)-count-20-|)
        
        let progress = UIProgressView()
        header.sv(progress)
        |-20-progress.bottom(0)-20-|
        progress.height(2)
        progress.layer.cornerRadius = 1
        progress.progressTintColor = .themeMainColor
        progress.trackTintColor = UIColor.themeMainColor.withAlphaComponent(0.2)

        
        var array = [Item]()
        switch section {
        case 0:
            label.text = "This morning"
            array = morningItems
        case 1:
            label.text = "This afternoon"
            array = dayItems
        case 2:
            label.text = "This evening"
            array = eveningItems
        default: ()
        }
        
        let totalCount = array.count
        let completedCount = array.filter { $0.isChecked }.count
        count.text = "\(completedCount) of \(totalCount) supplement\(totalCount > 0 ? "s" : "")".uppercased()

        
        label.font = UIFont(name: "Lato-Bold", size: 15)
        label.textColor = .themeDarkColor
        count.font = UIFont(name: "Lato-Bold", size: 10)
        count.textColor = .themeMainColor
        
        if totalCount > 0 {
            let completedRatio = Float(completedCount) / Float(totalCount)
            UIView.animate(withDuration: 1, animations: {
                progress.progress = completedRatio
            })
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.backgroundColor = .clear
        
        let rounded = UIView()
        footer.sv(rounded)
        |rounded.top(-8).height(16)|
        rounded.backgroundColor = .white
        rounded.layer.cornerRadius = 8
        
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 28
    }
    
    func item(for indexPath: IndexPath) -> Item {
        var item:Item!
        switch indexPath.section {
        case 0: item = morningItems[indexPath.row]
        case 1: item = dayItems[indexPath.row]
        case 2: item = eveningItems[indexPath.row]
        default:()
        }
        return item
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.item(for: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemCell.reuseIdentifier,
                                                       for: indexPath) as? ItemCell else {
            return UITableViewCell()
        }
        cell.render(with: item)
        cell.separator.isHidden = indexPath.row == 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var item:Item!
        switch indexPath.section {
        case 0: item = morningItems[indexPath.row]
        case 1: item = dayItems[indexPath.row]
        case 2: item = eveningItems[indexPath.row]
        default:()
        }
        
        let itemVC = ItemVC(item: item)
        itemVC.delegate = self
        
        let navVC = UINavigationController(rootViewController: itemVC)
        present(navVC, animated: true, completion: nil)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc
    func addNutrient() {
        let itemVC = ItemVC()
        itemVC.delegate = self
        let navVC = UINavigationController(rootViewController: itemVC)
        present(navVC, animated: true, completion: nil)
    }
    
    func itemVCDidSaveOrDeleteItem() {
        dismiss(animated: true, completion: nil)
        refresh()
    }
    
    func itemVCDidTapCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    func showMore() {
        navigationController?.pushViewController(MoreVC(), animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let selectedItem = item(for: indexPath)
        let action = UIContextualAction(style: .normal, title: selectedItem.isChecked ? "Untake" : "Take") { action, view, block in
            let checked = !selectedItem.isChecked
            let editedItem = Item(identifier: selectedItem.identifier,
                                  name: selectedItem.name,
                                  dosage: selectedItem.dosage,
                                  time: selectedItem.time,
                                  isChecked: checked)
            editedItem.saveInBackground()
            block(true)
            
            let hapticFeedback = UIImpactFeedbackGenerator(style: .medium)
            hapticFeedback.impactOccurred()
            
            self.refresh()
        }
        let img = #imageLiteral(resourceName: "check")
        action.image = img
        action.backgroundColor = UIColor.themeMainColor
        return UISwipeActionsConfiguration(actions: [action])
    }
}
