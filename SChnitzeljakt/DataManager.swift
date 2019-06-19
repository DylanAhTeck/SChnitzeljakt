//
//  File.swift
//  SChnitzeljakt
//
//  Created by Harrison Weinerman on 10/21/18.
//  Copyright © 2018 SChnitzeljakt. All rights reserved.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    var events: [String]?
    var loggedInUser: User?
    
    var foundPlane = false
    var followedJeff = false
    
    func updateStatus(lat: Float, long: Float, completion: (Status)->()) {
        completion(Status(progress: 1.0, achievement: .plane, nextHint: nil))
    }
    
    func login(username: String?, password: String) -> Bool {
        if username == "sycamore" && password == "calendar" {
            loggedInUser = User(name: "Sycamore Calendar", achievements: [.pokemon, .sunflower], isFollowing: false, profilePhotoURL: URL(string: "https://banner2.kisspng.com/20180418/gjw/kisspng-autohuerto-leaf-sycamore-maple-tree-american-sycam-5ad7af085b0b26.0025032615240844883729.jpg")!)
            return true
        } else {
            loggedInUser = nil
            DataManager.shared.foundPlane = false
            DataManager.shared.followedJeff = false
            return false
        }
    }
    
    func logout() {
        
    }
    
    func hunts() -> [Hunt] {
        return [Hunt(title: "USC Treasure Hunt")]
    }
    
    //return array of User profiles
    func users() -> [User]
    {
        let str_url : String? = "https://vignette.wikia.nocookie.net/disney/images/8/89/Cute-Cat.jpg/revision/latest?cb=20130828113117";
        let url = URL(string: str_url!);
        
        let list: [Achievement] =  [Achievement.plane];
        
        let user = [
            User(name: "Dylan", achievements: list, isFollowing: true, profilePhotoURL: url!)
        ];
        return user;
    }
    
    
    
    func profile_data() -> [profile_cell] {
        if loggedInUser == nil {
            return [profile_cell(Achievement: "Log in to save your progress and follow friends!", Data: "", image: "", ar: .plane)]
        }
        
        if !foundPlane {
            return [
            profile_cell(Achievement: "USC Treasure Hunt", Data: "Sunflower", image: "sunflower", ar: .sunflower),
            profile_cell(Achievement: "USC Treasure Hunt", Data: "Pokemon", image: "pokemon", ar: .pokemon),
            profile_cell(Achievement: "USC Treasure Hunt", Data: "Tree", image: "tree", ar: .tree)
            ]
        }
        
        let data = [
            profile_cell(Achievement: "USC Treasure Hunt", Data: "Plane", image: "plane", ar: .plane),
            profile_cell(Achievement: "USC Treasure Hunt", Data: "Sunflower", image: "sunflower", ar: .sunflower),
            profile_cell(Achievement: "USC Treasure Hunt", Data: "Pokemon", image: "pokemon", ar: .pokemon),
            profile_cell(Achievement: "USC Treasure Hunt", Data: "Tree", image: "tree", ar: .tree)
        ]
        
        return data
        
    }
    
    //returns array of activity objects
    func activity() -> [Activity] {
        if DataManager.shared.loggedInUser == nil {
            return [Activity(title: "Please log in to view your activity",
                             time: " ",
                             image: "https://img.freepik.com/free-icon/error-circle_318-26630.jpg?size=338&ext=jpg")]
        }
        
        if followedJeff {
            return [
                
                Activity(title: "Jeffrey found the Sunflower in USC Treasure Hunt!",
                         time: "1 hour ago",
                         image: "https://viterbi.usc.edu/directory/images/2dafc9bc59c736884ae57b7235d5bc67.jpg"),
                
                Activity(title: "Jeffrey found the Tree in USC Treasure Hunt!",
                         time: "1 hour ago",
                         image: "https://viterbi.usc.edu/directory/images/2dafc9bc59c736884ae57b7235d5bc67.jpg"),
                
                Activity(title: "Harrison found the Plane in USC Treasure Hunt!",
                         time: "2 hours ago",
                         image: "https://scontent-lax3-2.xx.fbcdn.net/v/t1.0-9/40297242_10209922243492544_6264375964910747648_o.jpg?_nc_cat=107&_nc_ht=scontent-lax3-2.xx&oh=9788b5011217a4843a583ef9a9faf4a4&oe=5C703EEA"),
                Activity(title: "Priyank found the Sunflower in USC Treasure Hunt!", time: "Yesterday", image: "https://scontent-lax3-1.xx.fbcdn.net/v/t1.0-9/13322178_137790406630784_5375978042727087620_n.jpg?_nc_cat=101&_nc_ht=scontent-lax3-1.xx&oh=d7ecd54b7a3e097852abec2f11fa05cb&oe=5C75C354"),
                Activity(title: "Roopal found the Sunflower in USC Treasure Hunt!", time: "Yesterday", image: "https://scontent-lax3-1.xx.fbcdn.net/v/t1.0-9/36246679_795383420668013_3312830097857183744_o.jpg?_nc_cat=100&_nc_ht=scontent-lax3-1.xx&oh=66c074989eb2a840b1c1064edf85a4fd&oe=5C6BE31C"),
                Activity(title: "Dylan found the Plane in USC Treasure Hunt!", time: "2 days ago", image: "https://media.licdn.com/dms/image/C5103AQEoTQ0nY_oJxA/profile-displayphoto-shrink_200_200/0?e=1548892800&v=beta&t=PX0lOPkzjvKtX6m4suo1pySYix2wZwFaiWQ8JBXibrI"),
                Activity(title: "Adelayde found the Sunflower in USC Treasure Hunt!", time: "2 days ago", image: "https://scontent-lax3-1.xx.fbcdn.net/v/t1.0-9/17554179_786199708196288_2565623605103856115_n.jpg?_nc_cat=101&_nc_ht=scontent-lax3-1.xx&oh=a5445b7e871f9c93cca3b69e26a60e93&oe=5C6DA4C5"),
                Activity(title: "Adelayde found the Tree in USC Treasure Hunt!", time: "2 days ago", image: "https://scontent-lax3-1.xx.fbcdn.net/v/t1.0-9/17554179_786199708196288_2565623605103856115_n.jpg?_nc_cat=101&_nc_ht=scontent-lax3-1.xx&oh=a5445b7e871f9c93cca3b69e26a60e93&oe=5C6DA4C5"),
                Activity(title: "Priyank found the Tree in USC Treasure Hunt!", time: "4 days ago", image: "https://scontent-lax3-1.xx.fbcdn.net/v/t1.0-9/13322178_137790406630784_5375978042727087620_n.jpg?_nc_cat=101&_nc_ht=scontent-lax3-1.xx&oh=d7ecd54b7a3e097852abec2f11fa05cb&oe=5C75C354"),
                Activity(title: "Roopal found the Tree in USC Treasure Hunt!", time: "5 days ago", image: "https://scontent-lax3-1.xx.fbcdn.net/v/t1.0-9/36246679_795383420668013_3312830097857183744_o.jpg?_nc_cat=100&_nc_ht=scontent-lax3-1.xx&oh=66c074989eb2a840b1c1064edf85a4fd&oe=5C6BE31C"),
                Activity(title: "Harrison found the Sunflower in USC Treasure Hunt!",
                         time: "1 week ago",
                         image: "https://scontent-lax3-2.xx.fbcdn.net/v/t1.0-9/40297242_10209922243492544_6264375964910747648_o.jpg?_nc_cat=107&_nc_ht=scontent-lax3-2.xx&oh=9788b5011217a4843a583ef9a9faf4a4&oe=5C703EEA"),
                Activity(title: "Dylan found the Sunflower in USC Treasure Hunt!", time: "1 week ago", image: "https://media.licdn.com/dms/image/C5103AQEoTQ0nY_oJxA/profile-displayphoto-shrink_200_200/0?e=1548892800&v=beta&t=PX0lOPkzjvKtX6m4suo1pySYix2wZwFaiWQ8JBXibrI"),
                Activity(title: "Dylan found the Tree in USC Treasure Hunt!", time: "1 week ago", image: "https://media.licdn.com/dms/image/C5103AQEoTQ0nY_oJxA/profile-displayphoto-shrink_200_200/0?e=1548892800&v=beta&t=PX0lOPkzjvKtX6m4suo1pySYix2wZwFaiWQ8JBXibrI"),
                Activity(title: "Harrison found the Tree in USC Treasure Hunt!",
                         time: "2 weeks ago",
                         image: "https://scontent-lax3-2.xx.fbcdn.net/v/t1.0-9/40297242_10209922243492544_6264375964910747648_o.jpg?_nc_cat=107&_nc_ht=scontent-lax3-2.xx&oh=9788b5011217a4843a583ef9a9faf4a4&oe=5C703EEA"),
                ]
        }
        
        
        let activities = [
            Activity(title: "Harrison found the Plane in USC Treasure Hunt!",
                     time: "2 hours ago",
                     image: "https://scontent-lax3-2.xx.fbcdn.net/v/t1.0-9/40297242_10209922243492544_6264375964910747648_o.jpg?_nc_cat=107&_nc_ht=scontent-lax3-2.xx&oh=9788b5011217a4843a583ef9a9faf4a4&oe=5C703EEA"),
            Activity(title: "Priyank found the Sunflower in USC Treasure Hunt!", time: "Yesterday", image: "https://scontent-lax3-1.xx.fbcdn.net/v/t1.0-9/13322178_137790406630784_5375978042727087620_n.jpg?_nc_cat=101&_nc_ht=scontent-lax3-1.xx&oh=d7ecd54b7a3e097852abec2f11fa05cb&oe=5C75C354"),
            Activity(title: "Roopal found the Sunflower in USC Treasure Hunt!", time: "Yesterday", image: "https://scontent-lax3-1.xx.fbcdn.net/v/t1.0-9/36246679_795383420668013_3312830097857183744_o.jpg?_nc_cat=100&_nc_ht=scontent-lax3-1.xx&oh=66c074989eb2a840b1c1064edf85a4fd&oe=5C6BE31C"),
            Activity(title: "Dylan found the Plane in USC Treasure Hunt!", time: "2 days ago", image: "https://media.licdn.com/dms/image/C5103AQEoTQ0nY_oJxA/profile-displayphoto-shrink_200_200/0?e=1548892800&v=beta&t=PX0lOPkzjvKtX6m4suo1pySYix2wZwFaiWQ8JBXibrI"),
            Activity(title: "Adelayde found the Sunflower in USC Treasure Hunt!", time: "2 days ago", image: "https://scontent-lax3-1.xx.fbcdn.net/v/t1.0-9/17554179_786199708196288_2565623605103856115_n.jpg?_nc_cat=101&_nc_ht=scontent-lax3-1.xx&oh=a5445b7e871f9c93cca3b69e26a60e93&oe=5C6DA4C5"),
            Activity(title: "Adelayde found the Tree in USC Treasure Hunt!", time: "2 days ago", image: "https://scontent-lax3-1.xx.fbcdn.net/v/t1.0-9/17554179_786199708196288_2565623605103856115_n.jpg?_nc_cat=101&_nc_ht=scontent-lax3-1.xx&oh=a5445b7e871f9c93cca3b69e26a60e93&oe=5C6DA4C5"),
            Activity(title: "Priyank found the Tree in USC Treasure Hunt!", time: "4 days ago", image: "https://scontent-lax3-1.xx.fbcdn.net/v/t1.0-9/13322178_137790406630784_5375978042727087620_n.jpg?_nc_cat=101&_nc_ht=scontent-lax3-1.xx&oh=d7ecd54b7a3e097852abec2f11fa05cb&oe=5C75C354"),
            Activity(title: "Roopal found the Tree in USC Treasure Hunt!", time: "5 days ago", image: "https://scontent-lax3-1.xx.fbcdn.net/v/t1.0-9/36246679_795383420668013_3312830097857183744_o.jpg?_nc_cat=100&_nc_ht=scontent-lax3-1.xx&oh=66c074989eb2a840b1c1064edf85a4fd&oe=5C6BE31C"),
            Activity(title: "Harrison found the Sunflower in USC Treasure Hunt!",
                     time: "1 week ago",
                     image: "https://scontent-lax3-2.xx.fbcdn.net/v/t1.0-9/40297242_10209922243492544_6264375964910747648_o.jpg?_nc_cat=107&_nc_ht=scontent-lax3-2.xx&oh=9788b5011217a4843a583ef9a9faf4a4&oe=5C703EEA"),
            Activity(title: "Dylan found the Sunflower in USC Treasure Hunt!", time: "1 week ago", image: "https://media.licdn.com/dms/image/C5103AQEoTQ0nY_oJxA/profile-displayphoto-shrink_200_200/0?e=1548892800&v=beta&t=PX0lOPkzjvKtX6m4suo1pySYix2wZwFaiWQ8JBXibrI"),
            Activity(title: "Dylan found the Tree in USC Treasure Hunt!", time: "1 week ago", image: "https://media.licdn.com/dms/image/C5103AQEoTQ0nY_oJxA/profile-displayphoto-shrink_200_200/0?e=1548892800&v=beta&t=PX0lOPkzjvKtX6m4suo1pySYix2wZwFaiWQ8JBXibrI"),
            Activity(title: "Harrison found the Tree in USC Treasure Hunt!",
                     time: "2 weeks ago",
                     image: "https://scontent-lax3-2.xx.fbcdn.net/v/t1.0-9/40297242_10209922243492544_6264375964910747648_o.jpg?_nc_cat=107&_nc_ht=scontent-lax3-2.xx&oh=9788b5011217a4843a583ef9a9faf4a4&oe=5C703EEA"),
        ]
        return activities;
    }
}




typealias AchievementId = Int

enum Achievement: Int {
    case tree, plane, pokemon, sunflower
    
    var filename: String {
        switch self {
        case .tree:
            return "Tree"
        case .plane:
            return "Plane"
        case .pokemon:
            return "Pokemon"
        case .sunflower:
            return "Sunflower"
        }
    }
}

struct User {
    var name: String
    var achievements: [Achievement]
    var isFollowing: Bool
    var profilePhotoURL: URL
}

struct Status {
    var progress: Float
    var achievement: Achievement?
    var nextHint: String?
}
struct Activity {
    var title: String
    var time: String
    var image: String
    
}

struct profile_cell {
    var Achievement: String;
    var Data: String;
    var image: String;
    var ar: Achievement
}
