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
        
        editarTextoSlider(boton: sliderA1, valor: textoA1.text!)
    }
    @IBAction func editarTextoA2(_ sender: Any) {
        editarTextoSlider(boton: sliderA2, valor: textoA2.text!)
    }
    @IBAction func editarTextoA3(_ sender: Any) {
        editarTextoSlider(boton: sliderA3, valor: textoA3.text!)
    }
    @IBAction func editarTextoA4(_ sender: Any) {
        editarTextoSlider(boton: sliderA4, valor: textoA4.text!)
    }
    @IBAction func editarTextoA5(_ sender: Any) {
        editarTextoSlider(boton: sliderA5, valor: textoA5.text!)
    }
    @IBAction func editarTextoA6(_ sender: Any) {
        editarTextoSlider(boton: sliderA6, valor: textoA6.text!)
    }
    
    func editarTextoSlider( boton: UISlider, valor: String ){
        do {
            let b = try getFloat(valor)
            boton.setValue(Float(b), animated: true)
        } catch MyError.conversionError {
            boton.setValue(Float(0), animated: true)
        } catch{
            boton.setValue(Float(0), animated: true)
        }
    }
    
    enum MyError : Error {
        case conversionError
    }
    
    func getFloat(_ data:String) throws -> Float
    {
        guard let result = Float(data) else { throw MyError.conversionError }
        return result
        
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
