//
//  FormsViewController.swift
//  C6_iOS_Project
//
//  Created by JeanPierre on 22/10/23.
//

import UIKit

class FormsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    

    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var txtDescripcionTitulo: UITextField!
    @IBOutlet weak var txtUbicacion: UITextField!
    @IBOutlet weak var txtDescripcion: UITextView!
    @IBOutlet weak var cboCategoria: UIPickerView!
    var titulo: String = ""
    var estado: Int = -1
    let categorias = ["Categoria 1", "Categoria 2", "Categoria 3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cboCategoria.delegate = self
        cboCategoria.dataSource = self
        lblTitulo.text = titulo
        //print(estado)
        // Do any additional setup after loading the view.
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categorias.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categorias[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        _ = categorias[row]
            // Puedes guardar la selección en una propiedad de la clase o hacer algo con ella.
        }
    @IBAction func btnPublicar(_ sender: UIButton) {
        let selectedCategoryRow = cboCategoria.selectedRow(inComponent: 0)
        let selectedCategory = categorias[selectedCategoryRow]
                
        let descripcionTitulo = txtDescripcionTitulo.text
        let ubicacion = txtUbicacion.text
        
        print(selectedCategory)
        print(descripcionTitulo ?? "")
        print(ubicacion ?? "")
        
    }

}
