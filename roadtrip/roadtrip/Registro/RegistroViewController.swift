//
//  RegistroViewController.swift
//  roadtrip
//
//  Created by Alejo Martín Arias Filippo on 01/12/2020.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit

class RegistroViewController: UIViewController {

    
    @IBOutlet weak var textoA1: UITextField!
    @IBOutlet weak var textoA2: UITextField!
    @IBOutlet weak var textoA3: UITextField!
    @IBOutlet weak var textoA4: UITextField!
    @IBOutlet weak var textoA5: UITextField!
    @IBOutlet weak var textoA6: UITextField!
    
    
    @IBOutlet weak var sliderA1: UISlider!
    @IBOutlet weak var sliderA2: UISlider!
    @IBOutlet weak var sliderA3: UISlider!
    @IBOutlet weak var sliderA4: UISlider!
    @IBOutlet weak var sliderA5: UISlider!
    @IBOutlet weak var sliderA6: UISlider!
    
    
    @IBOutlet weak var botonNo: UIButton!
    @IBOutlet weak var botonSi: UIButton!
    
    @IBOutlet weak var mapa: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func editarTexto(_ sender: Any) {
        
    }
    @IBAction func editarTextoA2(_ sender: Any) {
    }
    @IBAction func editarTextoA3(_ sender: Any) {
    }
    @IBAction func editarTextoA4(_ sender: Any) {
    }
    @IBAction func editarTextoA5(_ sender: Any) {
    }
    @IBAction func editarTextoA6(_ sender: Any) {
    }
    
    
    @IBAction func pulsarBotonSi(_ sender: Any) {
    }
    @IBAction func pulsaBotonNo(_ sender: Any) {
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
