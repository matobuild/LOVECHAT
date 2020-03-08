//
//  ViewController.swift
//  LOVECHAT
//
//  Created by kittawat phuangsombat on 2020/2/29.
//  Copyright © 2020 kittawat phuangsombat. All rights reserved.
//

import UIKit
import CLTypingLabel
class WelcomePage: UIViewController {

    @IBOutlet weak var titleLabel: CLTypingLabel!
    @IBOutlet weak var sloganLabel: CLTypingLabel!
    override func viewDidLoad() {
        super.viewDidLoad()
     //have to set the title name so that there is animation using cltypinglabel
        titleLabel.text = K.appName
        //after the tittle animation is finish the following code is excecute
        titleLabel.onTypingAnimationFinished = {
            self.sloganLabel.text = K.slogan
        }
            
        
        
        //hide the navigationbar shadow
self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }


}

