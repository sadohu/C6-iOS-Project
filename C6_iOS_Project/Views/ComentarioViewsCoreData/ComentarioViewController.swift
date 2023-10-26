//
//  ComentarioViewController.swift
//  C6_iOS_Project
//
//  Created by Mark Julca on 24/10/23.
//

import UIKit
//Implemente UITableViewDataSource que es un delegado
//Implementamos otro protocolo  metodo esto hace para el click , el UITableViewDelegate tiene metodo para click
class ComentarioViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {


        //Necesitamos Arreglo de ComentEntity inicializado en vacio
    var listaComentario:[ComentEntity]=[]
    //variable global para indexPath
        var posComent = -1
    //Obtengo uid
    var uidFromLogin4:String!
    var uidFromLogin5: String = ""
    //
    //Outlets y referencias de la tabla
    @IBOutlet weak var tvComentario: UITableView!
    //-----Agregamos este para refres -----Agregamos este para reload
          let refreshControl = UIRefreshControl();
          //---------------
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Llenar arreglo con metodo listarComentario
              //listaComentario = ControladorComentario().listarComentario()
        listaComentario = ControladorComentario().listarComentario(forUID: uidFromLogin4)
              //Indicando a la tabla que trabaja con origen de datos, this=self (esta clase)
        tvComentario.dataSource=self
              //esto con la intencion de que se haga click para accion debemos poner delegate
        tvComentario.delegate=self
              //Agregando altura o tamaño a la celda
        tvComentario.rowHeight=150
              //-----Agregamos este -----Agregamos este para reload
        refreshControl.addTarget(self, action: #selector(updateData), for: .valueChanged);
        tvComentario.refreshControl = refreshControl;
              //-------------------
      
    }//fin de viewDidLoad
    

    @IBAction func btnNuevo(_ sender: UIButton) {
        //llamar al segue  llamado "nuevo", donde ponemos nuevo y self , self es como this
                //para ir a la otra pantalla
                performSegue(withIdentifier: "nuevo", sender: self)
    }//fin de btnNuevo
    
    //Inicio de Metodos heredados
        //Metodo numero de filas en la seccion o cantidad de registros del arreglo,retorna - > Int
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            //retorna la cantidad de data
            return listaComentario.count
        }
        //metodo celda for fila retorna - > UITableViewCell
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            //Acceder al identificador llamado celda para acceder a los outlets de label e image
            let vista=tvComentario.dequeueReusableCell(withIdentifier: "celda") as! ItemTableViewCell
            //Acceder a los atributos , por medio de indexPath accedemos a los comentarios por su posicion
            //y mostramos los campos que queremos y lo parseamos a String por que es un label
            vista.txtComentario.text=listaComentario[indexPath.row].comenta
            //Retorna
            return vista
        }
        //Fin de metodos heredados
    
    
    //Metodo manual que creamos del UITableViewDelegate para pasar a otra pantalla
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            //variable posComent captura la posicion del objeto Comentario
            //esto con la finalidad de usarlo en esta linea
            posComent=indexPath.row
            //llamar al segue  llamado "datos", donde ponemos datos y self , self es como this
            //para ir a la otra pantalla
            performSegue(withIdentifier: "datos", sender: self)
            
        } //fin de tableView
    //Metodo para enviar datos a otra pantalla por que usamos Segue(Flecha) para pasar datos a otra pantalla
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           //validar Segue que si su identificador es datos se ejecute ese codigo para que
           //no interfiera con el segue llamado nuevo
           if segue.identifier == "datos" {
               
               //por medio de segue indicamos a que clase va a ir
               //crear objeto destino de la clase DatosViewController donde esta los txt completos
               let destino=segue.destination as! DatosViewController
               //accedemos a atributos
               destino.bean=listaComentario[posComent]
               
           } //fin de if
           else if segue.identifier == "nuevo" {
                   // Si el segue tiene el identificador "nuevo", pasamos a la pantalla NuevoComentViewController
               let des=segue.destination as! NuevoComentViewController
               des.u=self.uidFromLogin4
                   // Aquí debes agregar el código necesario para preparar el segue a NuevoComentViewController
               }
           
       }//fin de prepare
    
    //-----------------------------     //-----Agregamos este para reload
          @objc func updateData() {
            // Aquí obtener los datos actualizados
              //Llenar arreglo con metodo listarComentario
           //   listaComentario = ControladorComentario().listarComentario()
              listaComentario = ControladorComentario().listarComentario(forUID: uidFromLogin4)
            // Recargar la tabla
            self.tvComentario.reloadData()
            // Terminar animación refresh
            self.refreshControl.endRefreshing()
          }
      //---------------------------------------
    
}//fin de ComentarioViewController
