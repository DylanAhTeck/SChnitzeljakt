//
//  ActivityViewController.swift
//  SChnitzeljakt
//
//  Created by Harrison Weinerman on 10/19/18.
//  Copyright © 2018 SChnitzeljakt. All rights reserved.
//

import UIKit
import Nuke
class ActivityViewController: UITableViewController{
    
    var activities = DataManager.shared.activity()
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return activities.count
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activities = DataManager.shared.activity()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: "activityCell") as? ActivityTableViewCell else {
            return UITableViewCell()
        }
        let activity = activities[indexPath.row]

        cell.title?.text = activity.title
        cell.subtitle?.text = activity.time
        cell.profileImageView?.image = UIImage(named: "defaultProfPic")!
        cell.profileImageView?.layer.masksToBounds = true
        cell.profileImageView?.layer.cornerRadius = cell.profileImageView.frame.width / 2

        DispatchQueue.main.async {
            if let url = URL(string: activity.image), let imageView = cell.profileImageView {
                Nuke.loadImage(with: url, into: imageView)
            }
        }
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
