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
    @IBOutlet weak var ejex: UILabel!
    @IBOutlet weak var ejey: UILabel!
    @IBOutlet weak var guardarUbicacionRegistro: UIButton!
    @IBOutlet weak var guardarUbicacionPredeterminada: UIButton!
    
    var isCreacion : Bool = true
    
    var x : Float = 0.0
    var y : Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(x != 0.0 || y != 0.0 ){
            pin.center.x = CGFloat(x)
            pin.center.y = CGFloat(y-19.0)+88
            ejex.text = "\(x)"
            ejey.text = "\(y)"
        }
		
		
		guardarUbicacionPredeterminada.isHidden = isCreacion
		guardarUbicacionRegistro.isHidden = !isCreacion
    }
    
    @IBAction func seleccionarUbicacion(_ sender : UITapGestureRecognizer) {
        let ubicacionSeleccionada = sender.location(in: self.view)
        
        //Cojo los valores de la ubicación
        x = Float(ubicacionSeleccionada.x)
        y = Float(ubicacionSeleccionada.y)-88
        
        //Actualizo el puntero
        pin.center.x = CGFloat(x)
        pin.center.y = CGFloat(y-19.0)+88
        
        //Actualizo los campos de texto
        ejex.text = "\(x)"
        ejey.text = "\(y)"
    }

    @IBAction func guardarValores(_ sender: Any) {
        //dismiss(animated: true, completion: nil)
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
