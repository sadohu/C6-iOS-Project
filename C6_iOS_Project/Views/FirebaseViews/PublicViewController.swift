//
//  PublicViewController.swift
//  C6_iOS_Project
//
//  Created by Mark Julca on 23/10/23.
//

//import UIKit
import UIKit
//IMPORTAMOS PARA HACER CRUD
//import FirebaseFirestore
import FirebaseFirestore
class PublicViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tvPublicacion: UITableView!
    //Arreglo de estructura de Publicacion,arreglo de tipo Publicacion en vacio - > []
        var listaPublic:[Publicacion]=[]
        //variable global para indexPath
        var pos = -1
        //Crear objeto de acceso a la base de datos
        var BD = Firestore.firestore()
        
        //-----Agregamos este para refres -----Agregamos este para reload
           let refreshControl = UIRefreshControl();
           //---------------
    var cellType = (-1, "", "");
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //llamar al metodo de listadoPublic
               listadoPublic()
               //llamamos a la tabla para que traiga la data
        tvPublicacion.dataSource=self
               //esto con la intencion de que se haga click para accion debemos poner delegate
        tvPublicacion.delegate=self
               //Agregando altura o tamaño a la celda
        tvPublicacion.rowHeight=200
               //-----Agregamos este -----Agregamos este para reload
              refreshControl.addTarget(self, action: #selector(updateData), for: .valueChanged);
        tvPublicacion.refreshControl = refreshControl;
               //-------------------
        print(cellType)
        
    }//fin de viewDidLoad
    //--------METODOS HEREDADOS INICIO
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            //retorna la cantidad de data
            return listaPublic.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            //Acceder al identificador llamado itemPublicacion para acceder a los outlets de label
            let vista=tvPublicacion.dequeueReusableCell(withIdentifier: "itemPublicacion") as! PublicacionTableViewCell
            //Acceder a los atributos , por medio de indexPath accedemos a los medicamentos por su posicion
            //y mostramos los campos que queremos y lo parseamos a String por que es un label
            vista.lblTituloPubli.text=listaPublic[indexPath.row].titulopubli
            vista.lblDescripPubli.text=listaPublic[indexPath.row].descrippubli
            vista.lblNombrePer.text=listaPublic[indexPath.row].nombrepublicaper
            //Retorna
            return vista
        }
    
    //--------FIN DE METODOS HEREDADOS
    
    //Metodo manual que creamos del UITableViewDelegate para pasar a otra pantalla
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            //variable pos captura la posicion del objeto Publicacion
            //esto con la finalidad de usarlo en esta linea
            //destino.bean=listaClientes[posCliente] de func prepare
            pos=indexPath.row
            //llamar al segue  llamado "datosPubli", donde ponemos datos y self , self es como this
            //para ir a la otra pantalla
            performSegue(withIdentifier: "datosPubli", sender: self)
            
        } //fin de tableView
        //Metodo para enviar datos a otra pantalla por que usamos Segue(Flecha) para pasar datos a otra pantalla
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            //validar Segue que si su identificador es datosPubli se ejecute ese codigo para que
            //no interfiera con el otro segue
            if segue.identifier == "datosPubli" {
                
                //por medio de segue indicamos a que clase va a ir
                //crear objeto destino de la clase DatosPubliViewController donde esta los label completos
                let destino=segue.destination as! DatosPubliViewController
                //accedemos a atributos
                destino.data=listaPublic[pos]
                
            } //fin de if
        }//fin de prepare
    
    //creamos metodo para listadoPublic en firebase
        func listadoPublic(){
            //acceder a la coleccion publicacion de firestore, parametro data almacena la informacion y error los errores
            BD.collection("publicacion").addSnapshotListener{(data, error) in
                //al poner in debajo es la logica de programacion
                //validar parametro data
                //variable documentos tiene el valor de los datos de firestore
                //caso contrario iria al else mandando error con print y return
                //documentos tiene las uid y valor de comentinteres,descrippubli,descrippublicaper,nombrepublicaper,titulopubli
                guard let documentos = data?.documents else{
                //si entra al else es por que ocurrio algo
                    print("No existe publicaciones")
                    return
                }//fin de else
                //Adicionar datos al arreglo listaPublic creado arriba
                //usando map para recorrer luego lambda, variable bean de tipo Publicacion eso se retornara una Publicacion
                self.listaPublic = documentos.map{(bean)-> Publicacion in
                    /*
                    //Obtener el valor de bean
                    let row = bean.data()
                    //row  almacena de firestore los valores de de titulo y demas
                    //casteamos segun su tipo de  dato
                    //let titulo=row["titulopubli"] as! String
                    // variable UID para almacenar uid de bean que lo almacena
                    //ese uid largo 8f4TLrQX...
                    let pkuid = bean.documentID
                    //let titulo=row["titulopubli"] as! String
                    //let titu=row["titulopubli"] as! String
                    //let tit=fila["titulopubli"] as! String
                    //let titul="Hola"
                    let titu=row["titulopubli"] as? String
                    //let titul="Hola"
                    //let descripPubli=fila["descrippubli"] as! String
                    let despubli=row["descrippubli"] as? String
                
                    //let nombrePer=fila["nombrepublicaper"] as! String
                    let nombreper=row["nombrepublicaper"] as? String
                    
                    //let descripPer=fila["descrippublicaper"] as! String
                    let descripper=row["descrippublicaper"] as? String
                    let coment=row["comentinteres"] as? String
                    
                    //let descripPubli="De"
                    //enviamos al constructr del struct llamado Publicacion pasandole
                    //las variables titulo,descripPublic y demas que almacena lo de firestore
                    //a uid le pasamos UID
                    return Publicacion(uid: pkuid, titulopubli: titu, descrippubli: despubli, nombrepublicaper: nombreper, descrippublicaper: descripper, comentinteres: coment)
                    
                     
                     */
                    let row = bean.data()
                                
                                 let pkuid = bean.documentID
                                let titu = row["titulopubli"] as? String ?? ""
                    let despubli = row["descrippubli"] as? String ?? ""
                    let nombreper = row["nombrepublicaper"] as? String ?? ""
                    let descripper = row["descrippublicaper"] as? String ?? ""
                    let coment = row["comentinteres"] as? String ?? ""
                    //-----TIPO Y CATEGORIA ID
                    let catid = row["idCategoria"] as? Int ?? 0
                    let tipo = row["tipo"] as? String ?? ""
                    //
                                
                return Publicacion(uid: pkuid, idCategoria: catid, tipo: tipo, titulopubli: titu, descrippubli: despubli, nombrepublicaper: nombreper, descrippublicaper: descripper, comentinteres: coment)
                }//fin de map
                     
                //actualizar tabla o refrescar la tabla
                self.tvPublicacion.reloadData()
            }//fin de data,error
        }//fin de listadoPublic
   
    

    
    //-----------------------------     //-----Agregamos este para reload
         @objc func updateData() {
           // Aquí obtener los datos actualizados
             //Llenar arreglo con metodo listadoPublic
             listadoPublic()
           // Recargar la tabla
           self.tvPublicacion.reloadData()
           // Terminar animación refresh
           self.refreshControl.endRefreshing()
         }
     //---------------------------------------
}//fin de PublicViewController
