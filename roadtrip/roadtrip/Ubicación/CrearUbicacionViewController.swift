//
//  CrearUbicacionViewController.swift
//  roadtrip
//
//  Created by Alejo Martín Arias Filippo on 09/12/2020.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit

class CrearUbicacionViewController: UIViewController, UIImagePickerControllerDelegate {

    @IBOutlet weak var pin: UIImageView!
    @IBOutlet weak var ejex: UITextField!
    @IBOutlet weak var ejey: UITextField!
    
    var x : Double = 0.0
    var y : Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func seleccionarUbicacion(ubicacion : UITapGestureRecognizer) {
      
        let ubicacionSeleccionada = ubicacion.location(in: self.view)
        
        x = Double(ubicacionSeleccionada.x)
        y = Double(ubicacionSeleccionada.y)
        
        pin.center.x = CGFloat(x)
        pin.center.y = CGFloat(y)
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
