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
    
    @IBAction func seleccionarUbicacion(_ sender : UITapGestureRecognizer) {
        let ubicacionSeleccionada = sender.location(in: self.view)
        
        //Cojo los valores de la ubicación
        x = Double(ubicacionSeleccionada.x)
        y = Double(ubicacionSeleccionada.y)
        
        //Actualizo el puntero
        pin.center.x = CGFloat(x)
        pin.center.y = CGFloat(y)
        
        //Actualizo los campos de texto
        ejex.text = "\(x)"
        ejey.text = "\(y)"
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
