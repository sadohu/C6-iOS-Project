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

class FormsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, DataLoadedDelegate {
    
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var txtDescripcionTitulo: UITextField!
    @IBOutlet weak var txtUbicacion: UITextField!
    @IBOutlet weak var txtDescrip: UITextField!
    @IBOutlet weak var txtDecripGeneral: UITextField!
    @IBOutlet weak var cboCategoria: UIPickerView!
    @IBOutlet weak var cboTipo: UIPickerView!
    
    var titulo: String = ""
    var estado: Int = -1
    // Arrays para los cbo
    var categorias : [Categoria] = [];
    var listCategoriasFromApi : [Categoria] = [];
    var listTipos : [Categoria] = [];
    // Variables de captura del formulario (cbo)
    var idCategoria : Int = 0;
    var nombre = "", tipo = "";
    var typeFilterButton : Bool = false;
    
    //let categorias = [1, 2, 3]
    //Arreglo de estructura de Publicacion,arreglo de tipo Publicacion en vacio - > []
    var listaPublic:[Publicacion]=[]
    //Crear objeto de acceso a la base de datos
    var db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cboCategoria.delegate = self
        cboCategoria.dataSource = self
        cboTipo.delegate = self;
        cboTipo.dataSource = self;
        lblTitulo.text = titulo
        CustomConfig.getCategoriasFromApi(delegate: self);
        //print(estado)
        // Do any additional setup after loading the view.
    }
    
    func dataLoadedSuccessfully(data: [Categoria]) {
        listCategoriasFromApi = [];
        listTipos = [];
        categorias = [];
        listCategoriasFromApi = data.sorted{ $0.idCategoria < $1.idCategoria };
        listTipos = listCategoriasFromApi;
        categorias = CustomConfig.getCategoriasSection(listCategoriasFromApi);
        cboCategoria.reloadAllComponents();
    }
    
    func updateTipoPicker() {
        let selectedCategoryRow = cboCategoria.selectedRow(inComponent: 0)
        if selectedCategoryRow >= 0 && selectedCategoryRow < categorias.count {
            let selectedCategory = categorias[selectedCategoryRow]
            listTipos = listCategoriasFromApi.filter{$0.idCategoria == selectedCategory.idCategoria }
            cboTipo.reloadAllComponents();
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == cboCategoria {
            return categorias.count;
        } else if pickerView == cboTipo {
            return listTipos.count;
        }
        return 0;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == cboCategoria {
            return categorias[row].nombre;
        } else if pickerView == cboTipo {
            return listTipos[row].tipo;
        }
        return nil;
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == cboCategoria {
            let row = (cboCategoria.selectedRow(inComponent: 0));
            self.idCategoria = categorias[row].idCategoria;
            self.nombre = categorias[row].nombre;
            updateTipoPicker();
        }else if pickerView == cboTipo {
            let row = (cboTipo.selectedRow(inComponent: 0));
            self.tipo = listTipos[row].tipo;
        }
    }
    
    @IBAction func btnPublicar(_ sender: UIButton) {
        
        let descripcionTitulo = txtDescripcionTitulo.text
        let nombrepublicaper = txtUbicacion.text
        let descripcion = txtDescrip.text
        let descripPer = txtDecripGeneral.text
        //let selectedCategoryRow = cboCategoria.selectedRow(inComponent: 0)
        //let selectedCategory = categorias[selectedCategoryRow]
        //para clave - valor , se muestra categoria1 se guarda 1
        //let selectedCategory = selectedCategoryRow + 1
        // Crea un diccionario con los datos que deseas enviar a Firebase
        let data: [String: Any] = [
            "titulopubli": descripcionTitulo ?? "",
            "nombrepublicaper": nombrepublicaper ?? "",
            "descrippublicaper": descripPer ?? "",
            "descrippubli": descripcion ?? "",
            "tipo": self.tipo,
            "comentinteres" : self.nombre,
            "idCategoria": self.idCategoria,
            //"comentinteres": selectedCategory
        ]
        db.collection("publicacion").addDocument(data: data) { error in
            if error != nil {
                print("Error al guardar datos")
            } else {
                print("Datos guardados exitosamente")
                self.performSegue(withIdentifier: "formPostsSegue", sender: self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "formPostsSegue" {
            let view = segue.destination as! PublicViewController;
            view.cellType = (self.idCategoria, self.nombre, self.tipo);
            view.typeFilterButton = typeFilterButton;
        }
    }
}
