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
    
    
    @IBOutlet weak var ejecutarAlgoritmo: UIButton!
    
    @IBOutlet weak var mapa: UIImageView!
    
    var registro: Registro? = nil
    var edicion: Bool = false
    
    var a1 : Float = 0.0
    var a2 : Float = 0.0
    var a3 : Float = 0.0
    var a4 : Float = 0.0
    var a5 : Float = 0.0
    var a6 : Float = 0.0
    
    //Algoritmo activado o desactivado
    var ALGORITMO: Bool = true
    
    var ejex: Float = 0
    var ejey: Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if(ALGORITMO){
            ejecutarAlgoritmo.isHidden = false
            botonNo.isEnabled = false
            botonSi.isEnabled = false
        }
        
        if(edicion){
            actualizarAtributo(boton: sliderA1, texto: textoA1, valor: a1)
            actualizarAtributo(boton: sliderA2, texto: textoA2, valor: a2)
            actualizarAtributo(boton: sliderA3, texto: textoA3, valor: a3)
            actualizarAtributo(boton: sliderA4, texto: textoA4, valor: a4)
            actualizarAtributo(boton: sliderA5, texto: textoA5, valor: a5)
            actualizarAtributo(boton: sliderA6, texto: textoA6, valor: a6)
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func editarTexto(_ sender: Any) {
        editarTextoSlider(boton: sliderA1, texto: textoA1, atributo: &a1)
    }
    @IBAction func editarTextoA2(_ sender: Any) {
        editarTextoSlider(boton: sliderA2, texto: textoA2, atributo: &a2)
    }
    @IBAction func editarTextoA3(_ sender: Any) {
        editarTextoSlider(boton: sliderA3, texto: textoA3, atributo: &a3)
    }
    @IBAction func editarTextoA4(_ sender: Any) {
        editarTextoSlider(boton: sliderA4, texto: textoA4, atributo: &a4)
    }
    @IBAction func editarTextoA5(_ sender: Any) {
        editarTextoSlider(boton: sliderA5, texto: textoA5, atributo: &a5)
    }
    @IBAction func editarTextoA6(_ sender: Any) {
        editarTextoSlider(boton: sliderA6, texto: textoA6, atributo: &a6)
    }
    
    @IBAction func terminarEditarTexto(_ sender: Any) {
        terminarEditarTextoSlider(boton: sliderA1, texto: textoA1, atributo: a1)
    }
    @IBAction func terminarEditarTextoA2(_ sender: Any) {
        terminarEditarTextoSlider(boton: sliderA2, texto: textoA2, atributo: a2)
    }
    @IBAction func terminarEditarTextoA3(_ sender: Any) {
        terminarEditarTextoSlider(boton: sliderA3, texto: textoA3, atributo: a3)
    }
    @IBAction func terminarEditarTextoA4(_ sender: Any) {
        terminarEditarTextoSlider(boton: sliderA4, texto: textoA4, atributo: a4)
    }
    @IBAction func terminarEditarTextoA5(_ sender: Any) {
        terminarEditarTextoSlider(boton: sliderA5, texto: textoA5, atributo: a5)
    }
    @IBAction func terminarEditarTextoA6(_ sender: Any) {
        terminarEditarTextoSlider(boton: sliderA6, texto: textoA6, atributo: a6)
    }
    
    func terminarEditarTextoSlider( boton: UISlider, texto: UITextField, atributo: Float ){
        let valor = texto.text
        if(valor!.isEmpty) {
            texto.text="0"
            boton.setValue(0, animated: true)
        }
    }
    
    func editarTextoSlider( boton: UISlider, texto: UITextField, atributo: inout Float ){
        let valor = texto.text
        do {
            let b = try getFloat(valor!)
            boton.setValue(Float(b), animated: true)
        } catch MyError.conversionError {
            boton.setValue(Float(0), animated: true)
            texto.text = "\(0.0)"
            atributo = 0.0
        } catch{
            boton.setValue(Float(0), animated: true)
            texto.text = "\(0.0)"
            atributo = 0.0
        }
    }
    
    func actualizarAtributo(boton: UISlider, texto: UITextField, valor: Float){
        boton.setValue(valor, animated: true)
        texto.text = "\(valor)"
    }
    
    enum MyError : Error {
        case conversionError
    }
    
    func getFloat(_ data:String) throws -> Float
    {
        guard let result = Float(data) else { throw MyError.conversionError }
        return result
        
    }
    
    @IBAction func guardarUbicacionRegistro(sender: UIStoryboardSegue) {
        ejex = ((sender.source as! CrearUbicacionViewController).ejex.text! as NSString).floatValue
        ejey = ((sender.source as! CrearUbicacionViewController).ejey.text! as NSString).floatValue
        
        //ubicacion.text="\(ejex) | \(ejey)"
        
        actualizarRegistro()
    }
    
   
    
    @IBAction func pulsarBotonSi(_ sender: Any) {
        botonNo.isSelected = false
        botonSi.isSelected = true
    }
    @IBAction func pulsaBotonNo(_ sender: Any) {
        botonNo.isSelected = true
        botonSi.isSelected = false
    }
    
    
    //Compruebo que el registro es creado correctamente y habilito o deshabilito el botón de creación
    func actualizarRegistro(){
        
    }
    
    //Método cuando el botón ejecutar es pulsado
    @IBAction func ejecutarAlgoritmo(_ sender: Any) {
    }
    
    func algoritmo(){
    
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
