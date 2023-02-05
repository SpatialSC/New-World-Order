//
//  ViewController.swift
//  NewWorldOrder
//
//  Created by Vikram Agrawal on 2/4/23.
//

import UIKit
import RealityKit
import ARKit

class MenuVC: UIViewController {
    
    @IBOutlet var arView: ARView!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Experience.loadBox()
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
//        arView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapArView)))

        
        setupTableView()
    }
    
    //MARK: - Setup
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
    }
    
//    @objc func didTapArView(_ arView: ARView) {
//        print("tapped", arView)
//    }
//
//    func setupUsdzArView() {
//
////        arView = ARView(frame: .zero)
////        let model = try! ModelEntity.load(named: "pie")
//        let model = try! Entity.loadModel(named: "pie.usdz")
//        model.orientation = simd_quatf(angle: -.pi/2, axis: [1,0,0])
//        print("model:", model)
//
//
////        arView.session.run(ARWorldTrackingConfiguration())
//
//        let anchor = AnchorEntity()
////        anchor.position.y += 0.25
//        anchor.addChild(model)
////        arView.scene.addAnchor(anchor)
//        arView.scene.anchors.append(anchor)
//
//    }
    
}

extension MenuVC: UITableViewDelegate {
    
}

extension MenuVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
