//
//  ProfileDataViewController.swift
//  SChnitzeljakt
//
//  Created by Dylan  Ah Teck on 11/12/18.
//  Copyright © 2018 SChnitzeljakt. All rights reserved.
//

import UIKit

class HeadlineTableViewController: UITableViewController{
    
    var data = DataManager.shared.profile_data()
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data = DataManager.shared.profile_data()
        return data.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
            as! HeadlineTableViewCell
       
        cell.backgroundColor = .orange
        
        let profile_cell = data[indexPath.row]
        
        cell.AchievementLabel?.text = profile_cell.Achievement;
        cell.DataLabel?.text = profile_cell.Data;
        cell.IconImage?.image = UIImage(named: profile_cell.image)
        
        cell.IconImage.layer.masksToBounds = true
        cell.IconImage?.layer.cornerRadius = cell.IconImage.frame.width / 2

        /*
        let str_url : String? = "https://vignette.wikia.nocookie.net/disney/images/8/89/Cute-Cat.jpg/revision/latest?cb=20130828113117";
        let url = URL(string: str_url!);
        
        let pic = try? Data(contentsOf: url!); //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        cell.IconImage?.image = UIImage(data: pic!);
        */
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    
}

class HeadlineTableViewCell: UITableViewCell {
    
    @IBOutlet weak var IconImage: UIImageView!
    
    @IBOutlet weak var AchievementLabel: UILabel!
  
    @IBOutlet weak var DataLabel: UILabel!
    
   
}
