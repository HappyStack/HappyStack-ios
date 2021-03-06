//
//  MoreVC.swift
//  HappyStack
//
//  Created by Sacha DSO on 10/11/2017.
//  Copyright © 2017 HappyStack. All rights reserved.
//

import UIKit
import StoreKit
import MessageUI

class MoreVC : UITableViewController {
    
    convenience init() {
        self.init(style: UITableViewStyle.grouped)
        title = "More"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 0) ?  1 : 3 //"Safety first!" : "Help us :)"
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (section == 0) ? "Safety first!" : "Help us :)"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "MoreCell")
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "MoreCell")
        }
        
        if let c = cell {
            
            if (indexPath.section == 0) {
                c.accessoryType = .disclosureIndicator
                c.textLabel?.textAlignment = .left
                c.textLabel?.text = "Disclaimer"
            } else {
                c.accessoryType = .none
                c.textLabel?.textAlignment = .center
                c.detailTextLabel?.textColor = .gray
                switch indexPath.row {
                case 0:
                    c.textLabel?.text = "Share"
                    c.detailTextLabel?.text = "Your voice is powerful! 📢"
                case 1:
                    c.textLabel?.text = "Rate"
                    c.detailTextLabel?.text = "Every star counts ⭐️⭐️⭐️⭐️⭐️"
                case 2:
                    c.textLabel?.text = "Send us feedback"
                    c.detailTextLabel?.text = "We'd love to know what you think 👍👎💡?"
                default:
                    break
                }
            }
        }
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 0) {
            seeDisclaimer()
        }
        if (indexPath.section == 1) {
            switch indexPath.row {
            case 0:
                shareTheApp()
            case 1:
                rateTheApp()
            case 2:
                sendFeedback()
            default:
                break
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func seeDisclaimer() {
        //        let disclaimerVC = DisclaimerVC()
        //        self.navigationController?.pushViewController(disclaimerVC, animated: true)
    }
    
    func shareTheApp() {
        let textToShare = "Every one has a stack, what's yours? #happyStack";
        // let imageToShare = Put logo here
        // let urlToShare = Put url here (store website?)
        let activityItems = [textToShare];
        let excludedactivities: [UIActivityType] = [.postToWeibo,
                                  .assignToContact,
                                  .copyToPasteboard,
                                  .print,
                                  .saveToCameraRoll,
                                  .addToReadingList,
                                  .airDrop]
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        activityVC.excludedActivityTypes = excludedactivities
        
        present(activityVC, animated: true) { () -> Void in
            activityVC.excludedActivityTypes = nil  // Fixes array leak.
        }
    }
    
    func rateTheApp() {
        let appId = "" // TODO Put App Id here
        let storeViewController = SKStoreProductViewController()
        storeViewController.loadProduct(withParameters: [SKStoreProductParameterITunesItemIdentifier:appId], completionBlock: nil)
        storeViewController.delegate = self
        present(storeViewController, animated: true, completion: nil)
    }

    func sendFeedback() {
        let mailVC = MFMailComposeViewController()
        mailVC.mailComposeDelegate = self
        mailVC.setSubject("Feedback HappyStack")
        mailVC.setToRecipients(["sachadso@gmail.com", "nerv.junker@gmail.com"])
        present(mailVC, animated: true, completion: nil)
    }
}

extension MoreVC: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
}

extension MoreVC: SKStoreProductViewControllerDelegate {
    func productViewControllerDidFinish(_ viewController:SKStoreProductViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
}
