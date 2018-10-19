//
//  LogInVC.swift
//  testJSON
//
//  Created by Narongsak_O on 19/10/18.
//  Copyright © 2018 nProject. All rights reserved.
//

import UIKit

class LogInVC: UIViewController {

    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func pressLogInBtn(_ sender: UIButton) {
        
        let mainTVC = storyboard?.instantiateViewController(withIdentifier: "MainTabVC") as! MainTabVC
        
        present(mainTVC, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
