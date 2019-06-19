//
//  SecondViewController.swift
//  SChnitzeljakt
//
//  Created by Harrison Weinerman on 10/14/18.
//  Copyright © 2018 SChnitzeljakt. All rights reserved.
//


import UIKit
import Nuke

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    
    @IBOutlet var table: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    var animalArray = [Animal]()
    var currentAnimalArray = [Animal]() //update table
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAnimals()
        setUpSearchBar()
        alterLayout()
    }
    
    private func setUpAnimals() {
        animalArray.append(Animal(name: "Jeffrey Miller", category: .users, image: "https://viterbi.usc.edu/directory/images/2dafc9bc59c736884ae57b7235d5bc67.jpg"))
        
        animalArray.append(Animal(name: "Harrison Weinerman", category: .users, image:"https://scontent-lax3-2.xx.fbcdn.net/v/t1.0-9/40297242_10209922243492544_6264375964910747648_o.jpg?_nc_cat=107&_nc_ht=scontent-lax3-2.xx&oh=9788b5011217a4843a583ef9a9faf4a4&oe=5C703EEA"))
        
        animalArray.append(Animal(name: "Dylan Ah Teck", category: .users, image:"https://media.licdn.com/dms/image/C5103AQEoTQ0nY_oJxA/profile-displayphoto-shrink_200_200/0?e=1548892800&v=beta&t=PX0lOPkzjvKtX6m4suo1pySYix2wZwFaiWQ8JBXibrI"))
        
        animalArray.append(Animal(name: "Priyank Aranke", category: .users, image:"https://scontent-lax3-1.xx.fbcdn.net/v/t1.0-9/13322178_137790406630784_5375978042727087620_n.jpg?_nc_cat=101&_nc_ht=scontent-lax3-1.xx&oh=d7ecd54b7a3e097852abec2f11fa05cb&oe=5C75C354"))
        animalArray.append(Animal(name: "Roopal Kondepudi", category: .users, image:"https://scontent-lax3-1.xx.fbcdn.net/v/t1.0-9/36246679_795383420668013_3312830097857183744_o.jpg?_nc_cat=100&_nc_ht=scontent-lax3-1.xx&oh=66c074989eb2a840b1c1064edf85a4fd&oe=5C6BE31C"))
        animalArray.append(Animal(name: "Adelayde Rome", category: .users, image:"https://scontent-lax3-1.xx.fbcdn.net/v/t1.0-9/17554179_786199708196288_2565623605103856115_n.jpg?_nc_cat=101&_nc_ht=scontent-lax3-1.xx&oh=a5445b7e871f9c93cca3b69e26a60e93&oe=5C6DA4C5"))
        
        animalArray.append(Animal(name: "USC Treasure Hunt", category: .hunts, image:"https://www.usc.edu/wp-content/uploads/sites/2/2017/12/DSCF4643-crop2-300x189.jpg"))
        
        currentAnimalArray = animalArray
    }
    
    private func setUpSearchBar() {
        searchBar.scopeBarBackgroundImage = UIImage()
        searchBar.delegate = self
    }
    
    func alterLayout() {
        table.tableHeaderView = UIView()
        // search bar in section header
        table.estimatedSectionHeaderHeight = 50
        // search bar in navigation bar
        //navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchBar)
        navigationItem.titleView = searchBar
        searchBar.showsScopeBar = true // you can show/hide this dependant on your layout
        searchBar.placeholder = "Search for friends or hunts by name"
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
  
    // Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentAnimalArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TableCell else {
            return UITableViewCell()
        }
        cell.nameLbl.text = currentAnimalArray[indexPath.row].name
        cell.categoryLbl.text = currentAnimalArray[indexPath.row].category.rawValue
        cell.imgView?.image = UIImage(named: "defaultProfPic")!
        cell.imgView?.layer.masksToBounds = true
        cell.imgView?.layer.cornerRadius = cell.imgView.frame.width / 2

        
        
        DispatchQueue.main.async {
            if let url = URL(string: self.currentAnimalArray[indexPath.row].image) {
                Nuke.loadImage(with: url, into: cell.imgView)
            }
        }
//        cell.imgView.image = UIImage(named:currentAnimalArray[indexPath.row].image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        currentAnimalArray = animalArray.filter({ animal -> Bool in
            switch searchBar.selectedScopeButtonIndex {
            case 0:
                if searchText.isEmpty { return true }
                return animal.name.lowercased().contains(searchText.lowercased())
            case 1:
                if searchText.isEmpty { return animal.category == .users }
                return animal.name.lowercased().contains(searchText.lowercased()) &&
                    animal.category == .users
            case 2:
                if searchText.isEmpty { return animal.category == .hunts }
                return animal.name.lowercased().contains(searchText.lowercased()) &&
                    animal.category == .hunts
            default:
                return false
            }
        })
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if DataManager.shared.loggedInUser == nil {
            let alert = UIAlertController(title: "Sign in to add \(currentAnimalArray[indexPath.row].name)!",
                                          message: "Go to your profile to sign in so you can keep up with your friends' adventures.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let message = DataManager.shared.followedJeff ? "unfollow" : "follow"
        let alert = UIAlertController(title: "Follow this user?",
                                      message: "Would you like to \(message) " + currentAnimalArray[indexPath.row].name + "?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            DataManager.shared.followedJeff = !DataManager.shared.followedJeff
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0:
            currentAnimalArray = animalArray
        case 1:
            currentAnimalArray = animalArray.filter({ animal -> Bool in
                animal.category == AnimalType.hunts
            })
        case 2:
            currentAnimalArray = animalArray.filter({ animal -> Bool in
                animal.category == AnimalType.users
            })
        default:
            break
        }
        table.reloadData()
    }

}

class Animal {
    let name: String
    let image: String
    let category: AnimalType
    
    init(name: String, category: AnimalType, image: String) {
        self.name = name
        self.category = category
        self.image = image
    }
}
//>>>>>>> Stashed changes

enum AnimalType: String {
    case hunts = "Hunt"
    case users = "User"
}



class TableCell: UITableViewCell {
    
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var categoryLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}


