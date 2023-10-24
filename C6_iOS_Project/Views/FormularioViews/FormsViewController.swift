//
//  FormsViewController.swift
//  C6_iOS_Project
//
//  Created by JeanPierre on 22/10/23.
//

//import UIKit
import UIKit
//importamos
import FirebaseFirestore

class FormsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var txtDescripcionTitulo: UITextField!
    @IBOutlet weak var txtUbicacion: UITextField!
    
    
    @IBOutlet weak var txtTipoCateg: UITextField!
    
    @IBOutlet weak var txtDescrip: UITextField!
    @IBOutlet weak var txtDecripGeneral: UITextField!
    @IBOutlet weak var cboCategoria: UIPickerView!
    var titulo: String = ""
    var estado: Int = -1
    let categorias = ["Categoria 1", "Categoria 2", "Categoria 3"]
    //let categorias = [1, 2, 3]
    //Arreglo de estructura de Publicacion,arreglo de tipo Publicacion en vacio - > []
    var listaPublic:[Publicacion]=[]
    //Crear objeto de acceso a la base de datos
    var db = Firestore.firestore()
    
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
       // _ = categorias[row]
        let selectedCategoryRow = row + 1
        // Puedes guardar la selección en una propiedad de la clase o hacer algo con ella.
    }
    @IBAction func btnPublicar(_ sender: UIButton) {
        let descripcionTitulo = txtDescripcionTitulo.text
        let nombrepublicaper = txtUbicacion.text
        let descripcion = txtDescrip.text
        let descripPer = txtDecripGeneral.text
        let tipoCat = txtTipoCateg.text
        let selectedCategoryRow = cboCategoria.selectedRow(inComponent: 0)
        //let selectedCategory = categorias[selectedCategoryRow]
        //para clave - valor , se muestra categoria1 se guarda 1
        let selectedCategory = selectedCategoryRow + 1
        // Crea un diccionario con los datos que deseas enviar a Firebase
        let data: [String: Any] = [
            "titulopubli": descripcionTitulo ?? "",
            "nombrepublicaper": nombrepublicaper ?? "",
            "descrippublicaper": descripPer ?? "",
            "descrippubli": descripcion ?? "",
            "tipo": tipoCat ?? "",
            "comentinteres" : "",
            "idCategoria": selectedCategory
            //"comentinteres": selectedCategory
        ]
        
        db.collection("publicacion").addDocument(data: data) { error in
            if let error = error {
                print("Error al guardar datos")
            } else {
                print("Datos guardados exitosamente")
                self.performSegue(withIdentifier: "formPostsSegue", sender: self)
            }
        }
    }
}
