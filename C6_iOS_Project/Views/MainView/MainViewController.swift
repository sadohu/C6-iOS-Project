//
//  MainViewController.swift
//  C6_iOS_Project
//
//  Created by Sadohu on 22/10/23.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tvCategorias: UITableView!
    var listCategoria : [Categoria] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad();
        tvCategorias.dataSource = self;
        tvCategorias.rowHeight = 200;
        fillData();
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return listCategoria.count;
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return listCategoria[section].nombre;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let view = tvCategorias.dequeueReusableCell(withIdentifier: "tvCellCategoria") as! MainItemTableViewCell;
        view.lblCategoria.text = listCategoria[indexPath.row].nombre;
        return view;
    }

    func fillData(){
        listCategoria.append(Categoria(id: 1, idCategoria: 1, nombre: "Categoria 1", tipo: "Tipo 1", imagen: "https://www.becas-santander.com/content/dam/becasmicrosites/blog/trabajos-del-futuro.jpg"));
        listCategoria.append(Categoria(id: 2, idCategoria: 1, nombre: "Categoria 2", tipo: "Tipo 2", imagen: "https://www.becas-santander.com/content/dam/becasmicrosites/blog/trabajos-del-futuro.jpg"));
        listCategoria.append(Categoria(id: 3, idCategoria: 1, nombre: "Categoria 3", tipo: "Tipo 3", imagen: "https://www.becas-santander.com/content/dam/becasmicrosites/blog/trabajos-del-futuro.jpg"));
        listCategoria.append(Categoria(id: 4, idCategoria: 1, nombre: "Categoria 4", tipo: "Tipo 4", imagen: "https://www.becas-santander.com/content/dam/becasmicrosites/blog/trabajos-del-futuro.jpg"));
    }
}
