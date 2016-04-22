//
//  ViewController.swift
//  ChefPlate
//
//  Created by Shane Rosse on 4/9/16.
//  Copyright © 2016 Shane Rosse. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let plates: Plates = Plates()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        plates.startUp()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

