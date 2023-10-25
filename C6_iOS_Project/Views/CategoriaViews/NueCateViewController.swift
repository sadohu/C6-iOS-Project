//
//  NuevaCateViewController.swift
//  C6_iOS_Project
//
//  Created by Mark Julca on 21/10/23.
//

import UIKit

class NueCateViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, DataLoadedDelegate{
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtTipo: UITextField!
    @IBOutlet weak var txtImagen: UITextView!
    @IBOutlet weak var lblCboCategoria: UILabel!
    @IBOutlet weak var cboCategoria: UIPickerView!
    @IBOutlet weak var switchNewCategoria: UISwitch!
    
    var listCategoriasFromApi : [Categoria] = [];
    var categorias : [Categoria] = [];
    var idCategoria : Int = 0;
    var nombre = "", tipo = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cboCategoria.delegate = self;
        cboCategoria.dataSource = self;
        lblNombre.isHidden = false;
        txtNombre.isHidden = false;
        lblCboCategoria.isHidden = true;
        cboCategoria.isHidden = true;
        CustomConfig.getCategoriasFromApi(delegate: self);
    }//fin de viewDidload
    
    func dataLoadedSuccessfully(data: [Categoria]) {
        listCategoriasFromApi = [];
        categorias = [];
        listCategoriasFromApi = data.sorted{ $0.idCategoria < $1.idCategoria };
        categorias = CustomConfig.getCategoriasSection(listCategoriasFromApi);
        cboCategoria.reloadAllComponents();
    }

    @IBAction func btnGuardar(_ sender: UIButton) {
        //leermos lo de las cajas para eso creamos variables para coger la data de las cajas
        var nom = "", tipo = "", img = "";
        
        if(switchNewCategoria.isOn){
            let x = categorias.last!.idCategoria + 1;
            self.idCategoria = x;
            nom = txtNombre.text ?? ""
        }
        if(!switchNewCategoria.isOn){
            nom = self.nombre;
        }
        //asociamos las cajas con las variables
        tipo=txtTipo.text ?? ""
        img=txtImagen.text ?? ""
        //variable de tipo Medicamento struct
        let cat = Categoria(id: 0, idCategoria: self.idCategoria, nombre: nom, tipo: tipo, imagen: img);
        //llamamos al metodo
        grabarCategoria(bean: cat)
    }//fin de btnGuardar
    
    //creamos funcionar para grabar donde de parametro es bean de tipo Medicamento struct
        func grabarCategoria(bean:Categoria){
            //ponemos do catch para controlar excepciones
            do{
                //convertir a JSON el valor del parametro bean PARA SERIALIZAR JSON ENCODER
                let jsonData = try JSONEncoder().encode(bean)
                //almacenamos la URL de la API en una variable URLAPI
                let URLAPI = CustomConfig.URL_API + "/categoria/registrar"
                //convertimos a URL la variable URLAPI
                let urlRegistrar=URL(string: URLAPI)
                //creamos variable request que almacena un URLRequest y le pasamos en parametro
                //el urlRegistrar creado arriba,ponemos ! para decirle que si TENDRA DATOS Asegurando
                var request = URLRequest(url: urlRegistrar!)
                //especificar parametros es decir si es PUT DELETE POST
                request.httpMethod = "POST"
                //especificar que request es un JSON ,se va a enviar un JSON
                //ponemos en parametros application/json y Content Type
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                //respuesta del servicio sea JSON por eso el Accept
                request.setValue("application/json", forHTTPHeaderField: "Accept")
                //envio de JSON
                request.httpBody = jsonData
                //crear tarea
                //Con URLSession le pasamos el request de arriba
                //parametro data almacena la respuesta del JSON , la respuesta de confirmacion 201 Created
                //lo almacena response, parametro error para capturar el error por si hubiese
                //al poner in debajo de ello ira una logica
                let tarea=URLSession.shared.dataTask(with: request){data,response,error in
                    //para controlar con do
                    do{
                        //si error es nulo osea todo bien
                        if error==nil{
                            //variable datos almacena la DESERIALIZACION de Medicamento
                            // de parametro data que tiene la respuesta JSON
                            let datos = try JSONDecoder().decode(Categoria.self, from: data!)
                            //imprime datos cuando lo ingresa
                            print(datos)
                        }//fin de if
                    }//fin de segundo do
                    catch{
                        print(error.localizedDescription)
                    }//fin de catch
                    
                }//fin de URL SESSION
                //Iniciar tarea (el resume) es para que ejecute todo el codigo de arriba
                tarea.resume()
            }//fin del primer do
            catch{
                print("Error")
            }//fin de catch
        }//fin de grabarMedicamento
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == cboCategoria {
            return categorias.count;
        }
        return 0;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == cboCategoria {
            let row = (cboCategoria.selectedRow(inComponent: 0));
            self.idCategoria = categorias[row].idCategoria;
            self.nombre = categorias[row].nombre;
            return categorias[row].nombre;
        }
        return nil;
    }
    
    @IBAction func switchListener(_ sender: UISwitch) {
        if(sender.isOn){
            lblNombre.isHidden = false;
            txtNombre.isHidden = false;
            lblCboCategoria.isHidden = true;
            cboCategoria.isHidden = true;
        }else{
            lblNombre.isHidden = true;
            txtNombre.isHidden = true;
            lblCboCategoria.isHidden = false;
            cboCategoria.isHidden = false;
        }
    }
    
    
    
}//fin de NueCateViewController
