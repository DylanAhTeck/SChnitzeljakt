//
//  ARViewController.swift
//  SChnitzeljakt
//
//  Created by Harrison Weinerman on 10/28/18.
//  Copyright © 2018 SChnitzeljakt. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ARViewController: UIViewController {
    @IBOutlet weak var sceneView: ARSCNView!
    
    var achievement: Achievement?
    
    private let scene = SCNScene()
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.scene = scene
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = ARWorldTrackingConfiguration.PlaneDetection.horizontal
        sceneView.session.run(configuration)
        sceneView.autoenablesDefaultLighting = true
        show(achievement ?? .plane)
    }
    
    private func show(_ object: Achievement) {
        DataManager.shared.foundPlane = true
        guard let node = SCNScene(named: object.filename + ".scn")?.rootNode
            .childNode(withName: object.filename, recursively: true) else {
                print("Unable to unwrap object " + object.filename)
                return
        }
        node.position = SCNVector3(0, -1, 1)
        scene.rootNode.addChildNode(node)
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
