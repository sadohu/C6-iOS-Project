//
//  ControladorComentario.swift
//  C6_iOS_Project
//
//  Created by Mark Julca on 24/10/23.
//

import UIKit
import CoreData

class ControladorComentario: NSObject {

    //Creamos metodos
        //metodo para  registrar Comentario con parametro bean de tipo Comentario tipo structura
        func registrarComentario(bean:Comentario){
            //PASO 1:crear objeto de la clase AppDelegate y casteamos a AppDelegate
            let delegate = UIApplication.shared.delegate as! AppDelegate
            //PASO 2: acceder a la base de datos, y con viewContext para tener acceso a la bd ComentarioModel
            let contextoBD =  delegate.persistentContainer.viewContext
            //PASO 3: Indicar la tabla a trabajar, donde en context le pasamos la BD
            //que almacena en contextoBD
            let tabla = ComentEntity(context: contextoBD)
            //PASO 4: ASIGNARLE valores a los atributos del objeto "tabla" con los
            //atributos del parametro bean
            tabla.uid = bean.uid
            tabla.comenta = bean.comenta
            //PASO 5 GRABAR, ponerlo dentro de do catch es como try catch para controlar
            do{
                //llamando al contextoBD podemos acceder al metodo save
                try contextoBD.save()
            } catch let error as NSError{
                //para indentificar el error
                print(error.localizedDescription)
            } //fin de catch
        } //fin de registrarComentario
    
    //Método para listar Comentario, valor de retorno va a ser arreglo de ComentEntity
    //new
    func listarComentario(forUID uid: String) -> [ComentEntity] {
        //PASO 1:crear objeto de la clase AppDelegate y casteamos a AppDelegate
        let delegate = UIApplication.shared.delegate as! AppDelegate
        //PASO 2: acceder a la base de datos, y con viewContext para tener acceso a la bd ComentarioModel
        let contextoBD =  delegate.persistentContainer.viewContext
        // Aquí debes realizar una consulta en CoreData para obtener los comentarios que coincidan con el UID proporcionado.
        // Crea una NSPredicate para filtrar los comentarios por el UID.
        let predicate = NSPredicate(format: "uid == %@", uid)
        
        // Crea una solicitud de búsqueda con la entidad ComentEntity y aplica el predicado.
        let fetchRequest: NSFetchRequest<ComentEntity> = ComentEntity.fetchRequest()
        fetchRequest.predicate = predicate
        
        do {
            // Realiza la consulta en CoreData y devuelve los resultados.
            let comentarios = try contextoBD.fetch(fetchRequest)
            return comentarios
        } catch {
            print("Error al buscar comentarios: \(error)")
            return []
        }
    }

    //
       
    /*func listarComentario()->  [ComentEntity]{
            //PASO 1:crear objeto de la clase AppDelegate y casteamos a AppDelegate
            let delegate = UIApplication.shared.delegate as! AppDelegate
            //PASO 2: acceder a la base de datos, y con viewContext para tener acceso a la bd ComentarioModel
            let contextoBD =  delegate.persistentContainer.viewContext
            //PASO 3: Declarar Arreglo de la entidad ComentEntity,ponemos ! para
            //indicar que no estara inicializado, el ! es para solo declarar y no inicializar
            var resultado:[ComentEntity]!
            
            //PASO 4: Controlamos con do y try catch
            do{
                //Obtener lista de todo el contenido de la entidad ComentEntity
                //variable datos tiene listado por que le pusimos fetchRequest es como
                //select que trae todo lo que tiene ComentEntity lo almacena datos de tipo
                //NSFetchRequest
                let datos=ComentEntity.fetchRequest()
                //Convertir "datos" en un arreglo de ComentEntity
                resultado = try contextoBD.fetch(datos)
            } catch let error as NSError{
                //para indentificar el error
                print(error.localizedDescription)
            } //fin de catch
            //retornamos variable resultado que es arreglo de tipo ComentEntity
            return resultado
            
        } //fin de listarComentario
    */
    
    //Metodo para actualizar, con un parametro bean de tipo ComentEntity
        func actualizarComentario(bean:ComentEntity){
            //PASO 1:crear objeto de la clase AppDelegate y casteamos a AppDelegate
            let delegate = UIApplication.shared.delegate as! AppDelegate
            //PASO 2: acceder a la base de datos, y con viewContext para tener acceso a la bd ComentarioModel
            let contextoBD =  delegate.persistentContainer.viewContext
            //PASO 3: Controlar excepciones y actualizar pasandole la misma entidad entity
            do{
                //llamando al contextoBD podemos acceder al metodo save para actualizar
                //el save detecta que le pasamos un ComentEntity con datos
                try contextoBD.save()
            } catch let error as NSError{
                //para indentificar el error
                print(error.localizedDescription)
            } //fin de catch
        } //fin de actualizarComentario
    
    //Metodo para eliminar con un parametro bean de tipo ComentEntity
       func eliminarComentario(bean:ComentEntity){
           
           //PASO 1:crear objeto de la clase AppDelegate y casteamos a AppDelegate
           let delegate = UIApplication.shared.delegate as! AppDelegate
           //PASO 2: acceder a la base de datos, y con viewContext para tener acceso a la bd ComentarioModel
           let contextoBD =  delegate.persistentContainer.viewContext
           //PASO 3: Controlar excepciones y eliminar pasandole la misma entidad entity
           do{
               //por medio de contextoBD llamamos al delete y le pasamos el objeto bean de tipo
               //ComentEntity
               contextoBD.delete(bean)
               //paso 4: GRABAR la eliminacion
               try contextoBD.save()
           } catch let error as NSError{
               //para indentificar el error
               print(error.localizedDescription)
           } //fin de catch
       }//fin de eliminarComentario
}//fin de ControladorComentario
