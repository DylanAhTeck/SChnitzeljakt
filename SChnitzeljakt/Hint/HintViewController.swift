//
//  HintViewController.swift
//  SChnitzeljakt
//
//  Created by Harrison Weinerman on 10/19/18.
//  Copyright © 2018 SChnitzeljakt. All rights reserved.
//

import UIKit
import MapKit

class HintViewController: UIViewController {
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var hintLabel: UILabel!
    
    private var achievement: Achievement? {
        didSet {
            if let _ = achievement {
                performSegue(withIdentifier: "ar", sender: self)
            }
        }
    }
    
    let locationManager = CLLocationManager()
    var hunt: Hunt?
    var mostRecentLocation: CLLocation?
    
    private var status: Status? {
        didSet {
            guard let status = status else {
                return
            }
            // Update progress and hint
            progressView.setProgress(status.progress, animated: true)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                // If found item, update achivement and show
                if let achievement = status.achievement {
                    self.achievement = achievement
                }
                
            }
           
            // Update hint if necessary to subsequent hint
            hintLabel.text = status.nextHint ?? hintLabel.text
        }
    }
    private var updateTimer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        // todo: temp
//        achievement = .plane
        progressView.progress = 0
        setupLocation()
    }

    override func viewWillAppear(_ animated: Bool) {
        title = hunt?.title
    }

    var shouldOpen = true
    override func viewDidAppear(_ animated: Bool) {
        guard shouldOpen else { return }
        
        updateTimer = Timer.scheduledTimer(withTimeInterval: 5,
                                           repeats: false) { [weak self] _ in
            guard let strongSelf = self,
                let lat = strongSelf.mostRecentLocation?.coordinate.latitude,
                let long = strongSelf.mostRecentLocation?.coordinate.longitude else {
                    return
            }
            DataManager.shared.updateStatus(lat: Float(lat), long: Float(long),
                                            completion: { (status) in
                strongSelf.status = status
            })
        }
        
        
        

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        updateTimer?.invalidate()
    }

    @IBAction func next(_ sender: Any) {
        self.performSegue(withIdentifier: "ar", sender: self)
    }
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let arVC = segue.destination as? ARViewController else {
            return
        }
        arVC.achievement = achievement
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            // If found item, update achivement and show
            self.hintLabel.text = "This statue was duct-taped during Conquest."
            self.progressView.progress = 0
            self.shouldOpen = false
        }
    }
    
}
