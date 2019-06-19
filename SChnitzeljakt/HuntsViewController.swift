//
//  FirstViewController.swift
//  SChnitzeljakt
//
//  Created by Harrison Weinerman on 10/14/18.
//  Copyright © 2018 SChnitzeljakt. All rights reserved.
//

import UIKit
import Nuke

struct Hunt {
    var title: String
}

class HuntsViewController: UITableViewController {
    private var hunts: [Hunt] = []
    private var selectedHunt: Hunt?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hunts = DataManager.shared.hunts()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "hunt") as? HuntTableViewCell else {
            return UITableViewCell()
        }
        cell.huntImageView?.layer.masksToBounds = true
        cell.huntImageView?.layer.cornerRadius = cell.huntImageView.frame.width / 2
        
        selectedHunt = hunts[indexPath.row]
        cell.titleLabel?.text = selectedHunt?.title
        Nuke.loadImage(with: URL(string: "https://www.usc.edu/wp-content/uploads/sites/2/2017/12/DSCF4643-crop2-300x189.jpg")!, into: cell.huntImageView)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "hint", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let hintVC = segue.destination as? HintViewController else {
            return
        }
        hintVC.hunt = selectedHunt
    }
}

