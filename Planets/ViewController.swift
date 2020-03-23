//
//  ViewController.swift
//  Planets
//
//  Created by Karthik S on 23/03/2020.
//  Copyright © 2020 Karthik S. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    let configuration = ARWorldTrackingConfiguration()
    @IBOutlet weak var sceneview: ARSCNView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.sceneview.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneview.session.run(configuration)
        self.sceneview.autoenablesDefaultLighting = true
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool)
    {
        let sun = SCNNode(geometry: SCNSphere(radius: 0.35))
        let earthParent = SCNNode()
        let venusParent = SCNNode()
        sun.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "Sundiffuse")
        sun.position = SCNVector3(0,0,-1)
        earthParent.position = SCNVector3(0,0,-1)
        venusParent.position = SCNVector3(0,0,-1)
        
        self.sceneview.scene.rootNode.addChildNode(sun)
        self.sceneview.scene.rootNode.addChildNode(earthParent)
        self.sceneview.scene.rootNode.addChildNode(venusParent)
        
        let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: UIImage(named: "Earthday"), specular: UIImage(named: "Earthspecular"), emission: UIImage(named: "Earthemission"), normal: UIImage(named: "Earthnormal"), position: SCNVector3(1.2,0,0))
        sun.addChildNode(earth)
        
        let venus = planet(geometry: SCNSphere(radius: 0.1), diffuse: UIImage(named: "Venussurface")!, specular: nil, emission: UIImage(named: "Venusatmosphere"), normal: nil, position: SCNVector3(0.7,0,0))
        sun.addChildNode(venus)
        
        /* Earth Code
        let earth = SCNNode()
        earth.geometry = SCNSphere(radius: 0.15)
        earth.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "Earthday")
        earth.geometry?.firstMaterial?.specular.contents = UIImage(named: "Earthspecular")
        earth.geometry?.firstMaterial?.emission.contents = UIImage(named: "Earthemission")
        earth.geometry?.firstMaterial?.normal.contents = UIImage(named: "Earthnormal")
        earth.position = SCNVector3(1.2,0,0)
        sun.addChildNode(earth) */
        
        // rotation of planets
        let action = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: 8)
        let forever = SCNAction.repeatForever(action)
        sun.runAction(forever)
        earthParent.addChildNode(earth)
        venusParent.addChildNode(venus)
        
        let earthPartentRotation = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: 14)
        let venusPartentRotation = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: 10)

        let foreverEarth = SCNAction.repeatForever(earthPartentRotation)
        let foreverVenus = SCNAction.repeatForever(venusPartentRotation)
        
        earthParent.runAction(foreverEarth)
        venusParent.runAction(foreverVenus)
//        earth.runAction(forever)
//        venus.runAction(forever)
    }
    func planet(geometry: SCNGeometry, diffuse: UIImage?, specular: UIImage?, emission: UIImage?, normal: UIImage?, position: SCNVector3) -> SCNNode {
        let planet = SCNNode(geometry: geometry)
        planet.geometry?.firstMaterial?.diffuse.contents = diffuse
        planet.geometry?.firstMaterial?.specular.contents = specular
        planet.geometry?.firstMaterial?.emission.contents = emission
        planet.geometry?.firstMaterial?.normal.contents = normal
        planet.position = position
        return planet
    }

}

extension Int {
    
    var degreesToRadians: Double { return Double(self) * .pi/180}
}
