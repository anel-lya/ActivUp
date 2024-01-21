//
//  StartViewController.swift
//  ActivUp
//
//  Created by Anel Rustamova on 05.12.2023.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let isF = IsFirstDataManager.shared.fetchIsFirst()
        if (!isF){
            start(animated)
        }
        
    }

    @IBAction func start(_ sender: Any) {
        
        let new = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as? TabBarController
        new!.modalPresentationStyle = .fullScreen
        self.present(new!, animated : false, completion : nil)
        
    }
}
