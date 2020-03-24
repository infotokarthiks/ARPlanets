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
        let moonParent = SCNNode()
        
        //Positioning of Planets
        sun.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "Sundiffuse")
        sun.position = SCNVector3(0,0,-1)
        earthParent.position = SCNVector3(0,0,-1)
        venusParent.position = SCNVector3(0,0,-1)
        moonParent.position = SCNVector3(1.2,0,0)
        
        self.sceneview.scene.rootNode.addChildNode(sun)
        self.sceneview.scene.rootNode.addChildNode(earthParent)
        self.sceneview.scene.rootNode.addChildNode(venusParent)
        
        //Code for Geometrical Specifications of Planets
        let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: UIImage(named: "Earthday"), specular: UIImage(named: "Earthspecular"), emission: UIImage(named: "Earthemission"), normal: UIImage(named: "Earthnormal"), position: SCNVector3(1.2,0,0))
        sun.addChildNode(earth)
        
        let venus = planet(geometry: SCNSphere(radius: 0.1), diffuse: UIImage(named: "Venussurface"), specular: nil, emission: UIImage(named: "Venusatmosphere"), normal: nil, position: SCNVector3(0.7,0,0))
        sun.addChildNode(venus)
        
        let moon = planet(geometry: SCNSphere(radius: 0.05), diffuse: UIImage(named: "Moondiffuse"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0,0,-0.3))
        
        //Code for Rotation of planets
        let sunAction = Rotation(time: 8)
        let earthParentRotation = Rotation(time: 14)
        let venusParentRotation = Rotation(time: 10)
        let earthRotation = Rotation(time: 8)
        let moonRotation = Rotation(time: 4)
        let venusRotation = Rotation(time: 8)

        earth.runAction(earthRotation)
        venus.runAction(venusRotation)
        earthParent.runAction(earthParentRotation)
        venusParent.runAction(venusParentRotation)
        moonParent.runAction(moonRotation)
        
        sun.runAction(sunAction)
        earthParent.addChildNode(earth)
        earthParent.addChildNode(moonParent)
        venusParent.addChildNode(venus)
        earth.addChildNode(moon)
        moonParent.addChildNode(moon)
    }
    
    // Defines Planets Geometrical Structure and Layers
    func planet(geometry: SCNGeometry, diffuse: UIImage?, specular: UIImage?, emission: UIImage?, normal: UIImage?, position: SCNVector3) -> SCNNode
    {
        let planet = SCNNode(geometry: geometry)
        planet.geometry?.firstMaterial?.diffuse.contents = diffuse
        planet.geometry?.firstMaterial?.specular.contents = specular
        planet.geometry?.firstMaterial?.emission.contents = emission
        planet.geometry?.firstMaterial?.normal.contents = normal
        planet.position = position
        return planet
    }
    
    // Defines the Rotation of Planets
    func Rotation(time: TimeInterval) -> SCNAction
    {
        let Rotation = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: time)
        let foreverRotation = SCNAction.repeatForever(Rotation)
        return foreverRotation
    }

}
    // To convert from degree to Radians for the
    extension Int
    {
    var degreesToRadians: Double { return Double(self) * .pi/180}
    }
