//
//  ProfileViewController.swift
//  SChnitzeljakt
//
//  Created by Harrison Weinerman on 10/19/18.
//  Copyright © 2018 SChnitzeljakt. All rights reserved.
//

import UIKit
//import Firebase
import Nuke


class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,
UITableViewDelegate,
UITableViewDataSource{
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profile_img: UIImageView!
    @IBOutlet weak var name_label: UILabel!
    
    
    //Functions
    @IBAction func upload_picture(_ sender: Any) {
        
        let picker = UIImagePickerController()
        picker.delegate = self;
        picker.allowsEditing = true
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    
   private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        }
        else if let orginalImage = info["UIImagePickerControllerOrginalImage"] as? UIImage{
            selectedImageFromPicker = orginalImage
        }
        if let selectedImage = selectedImageFromPicker {
            profile_img?.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
        }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    //let databaseRef = FIRDatabase.database().reference()
    
    @objc func logOut(){
        DataManager.shared.loggedInUser = nil
        navigationController?.tabBarController?.dismiss(animated: true, completion: nil)
    }
    
 
    
    override func viewDidLoad(){
        super.viewDidLoad();
        
        tableView.layer.cornerRadius = 5
        tableView.layer.masksToBounds = true
        
        profile_img.layer.cornerRadius = profile_img.frame.size.width/2
        profile_img.clipsToBounds = true;
        
        guard let profile = DataManager.shared.loggedInUser else {
            name_label.text = "Guest user"
            profile_img.image = UIImage(named: "defaultProfPic")!
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign In",
                                                                     style: .plain,
                                                                     target: self,
                                                                     action: #selector(logOut))
            return
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out",
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(logOut))
        name_label?.text = profile.name;
        Nuke.loadImage(with: profile.profilePhotoURL, into: profile_img)
        
    }
    
    var data = DataManager.shared.profile_data()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data = DataManager.shared.profile_data()
        return data.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        open(achievement: data[indexPath.row].ar)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
            as! HeadlineTableViewCell
        
        let profile_cell = data[indexPath.row]
        cell.AchievementLabel?.text = profile_cell.Achievement;
        cell.DataLabel?.text = profile_cell.Data;
        cell.IconImage?.image = UIImage(named: profile_cell.image)
        
        cell.IconImage.layer.masksToBounds = true
        cell.IconImage?.layer.cornerRadius = cell.IconImage.frame.width / 2
        
        return cell
    }
    var achievement: Achievement!
    func open(achievement: Achievement) {
        self.achievement = achievement
        performSegue(withIdentifier: "ar", sender: self)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let arVC = segue.destination as? ARViewController else {
            return
        }
        arVC.achievement = achievement
    }
    
 }
