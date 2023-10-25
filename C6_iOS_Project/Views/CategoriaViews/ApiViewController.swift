//
//  ApiViewController.swift
//  C6_iOS_Project
//
//  Created by Mark Julca on 21/10/23.
//

import UIKit


class ApiViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    //Arreglo de estructura de Categoria,arreglo de tipo Categoria en vacio - > []
       var listaCategorias:[Categoria]=[]
    //variable global para indexPath
        var posCate = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //llamar al metodo de cargarCategorias
                cargarCategorias()
        //llamamos a la tabla para que traiga la data
        myTableView.dataSource=self
               //esto con la intencion de que se haga click para accion debemos poner delegate
        myTableView.delegate=self               //Agregando altura o tamaño a la celda
        myTableView.rowHeight=150

    }//fin de viewDidLoad
    
    override func viewWillAppear(_ animated: Bool) {
            /* Segundo método para recarga de datos */
        cargarCategorias();
        
        }
    
    //creamos funcion para listar todos los medicamentos del API
        func cargarCategorias(){
            //almacenamos la URL de la API en una variable URLAPI
            let URLAPI = CustomConfig.URL_API + "/categoria/listar";
            //convertimos a URL la variable URLAPI
            let url=URL(string: URLAPI)
            //Con URLSession le pasamos el url de arriba ya convertido en el with
            // el ! para indicarle que hay informacion
            //parametro data almacena la respuesta del JSON , la respuesta de confirmacion 200 OK
            //lo almacena response, parametro error para capturar el error por si hubiese
            //al poner in debajo de ello ira una logica
            let tarea=URLSession.shared.dataTask(with: url!){data,response,error in
                //Controlar por si hubiese error
                do{
                    // si error es nil osea todo esta bien
                    if error == nil{
                        //leer lo que devuelve api es decir DESERIALIZAR con jsondecoder
                        //ponemos try por si sale una excepcion
                        //primer parametro es un arreglo de lo que devuelve el API
                        //lo que devuelve son varios medicamentos entonces ponemos array []
                        //de la estructura Medicamento y con self indicamos que esta aca
                        //ponemos ! a data por que estamos seguro que tiene valor
                        //entonces variable medicamentos tiene todo el valor de la API de la URL
                        let categoria = try JSONDecoder().decode([Categoria].self, from: data!)
                        //igualamos al arreglo creado arriba llamado listaMedicamentos
                        //con la variable medicamentos que tiene la data de la URL
                        self.listaCategorias = categoria
                        //imprimimos
//                        print(categoria)
                        //refrescar la tabla debe ser asincrona en segundo plano por hilo
                        DispatchQueue.main.async {
                            self.myTableView.reloadData()
                        } //fin de DispatchQueue
                        
                    } //fin de if
                    
                }//fin de do
                catch{
                    print(error.localizedDescription)
                    //print(String(describing: error))
                }//fin de catch
                
                
            }//fin URLSession
            //Iniciar tarea (el resume) es para que ejecute todo el codigo de arriba
            tarea.resume()
            
        } //fin de cargarMedicamentos
    
    
    

    //METODOS HEREDADOS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaCategorias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cellAPI") as! MTableViewCell
        cell.myLabel.text="Tipo : "+listaCategorias[indexPath.row].tipo
        let img = listaCategorias[indexPath.row].imagen
        //--------------------------------- Para imprimir en myImage
        let url = URL(string: img)
        let data = try? Data(contentsOf: url!)
        cell.myImage.image = UIImage(data: data!)
        
       //retorna
        return cell
    }//fin de tableView
    //METODOS HEREDADOS
    
    //Metodo manual que creamos del UITableViewDelegate para pasar a otra pantalla
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            //variable posCliente captura la posicion del objeto Cliente
            //esto con la finalidad de usarlo en esta linea
            //destino.bean=listaClientes[posCliente] de func prepare
            posCate=indexPath.row
            //llamar al segue  llamado "datos", donde ponemos datos y self , self es como this
            //para ir a la otra pantalla
            performSegue(withIdentifier: "editarCategoria", sender: self)
            
        } //fin de tableView
        //Metodo para enviar datos a otra pantalla por que usamos Segue(Flecha) para pasar datos a otra pantalla
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            //validar Segue que si su identificador es editarMedicamento se ejecute ese codigo para que
            //no interfiera con el otro segue
            if segue.identifier == "editarCategoria" {
                
                //por medio de segue indicamos a que clase va a ir
                //crear objeto destino de la clase EditarMedicamentoViewController donde esta los label completos
                let destino=segue.destination as! EditarCateViewController
                //accedemos a atributos
                destino.categ=listaCategorias[posCate]
                
            } //fin de if
        }//fin de prepare
    
    
    

   
    
    
    @IBAction func btnNuevo(_ sender: UIButton) {
        performSegue(withIdentifier: "nuevoCate", sender: nil)
        
    }//fin de btnNuevo
    
    
    
}//fin de APIViewController


