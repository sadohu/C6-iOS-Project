//
//  MainViewController.swift
//  C6_iOS_Project
//
//  Created by Sadohu on 22/10/23.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tvCategorias: UITableView!
    var listFromApi : [Categoria] = [];
    var listCategoria : [Categoria] = [];
    var ids : [Int] = [];
    var nombre : [String] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad();
        tvCategorias.dataSource = self;
        tvCategorias.rowHeight = 200;
        fillData();
        listCategoria = CustomConfig.getCategoriasSection(listFromApi);
        dataForCells(listCategoria);
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ids.count;
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nombre[section];
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let view = tvCategorias.dequeueReusableCell(withIdentifier: "tvCellCategoria") as! MainItemTableViewCell;
        let categoryId = self.ids[indexPath.section];
        let listA = listFromApi.filter { $0.idCategoria == categoryId };
            
        view.listCategoria = listA;
        return view;
    }
    
    func dataForCells(_ list : [Categoria]){
        for id in list{
            self.ids.append(id.idCategoria);
            self.nombre.append(id.nombre)
        }
    }

    func fillData(){
        listFromApi.append(Categoria(id: 1, idCategoria: 1, nombre: "Categoria 1", tipo: "Tipo 1-1", imagen: "https://www.becas-santander.com/content/dam/becasmicrosites/blog/trabajos-del-futuro.jpg"));
        listFromApi.append(Categoria(id: 2, idCategoria: 2, nombre: "Categoria 2", tipo: "Tipo 2-1", imagen: "https://www.becas-santander.com/content/dam/becasmicrosites/blog/trabajos-del-futuro.jpg"));
        listFromApi.append(Categoria(id: 3, idCategoria: 2, nombre: "Categoria 2", tipo: "Tipo 2-2", imagen: "https://www.becas-santander.com/content/dam/becasmicrosites/blog/trabajos-del-futuro.jpg"));
        listFromApi.append(Categoria(id: 4, idCategoria: 3, nombre: "Categoria 3", tipo: "Tipo 3-1", imagen: "https://www.becas-santander.com/content/dam/becasmicrosites/blog/trabajos-del-futuro.jpg"));
        listFromApi.append(Categoria(id: 4, idCategoria: 3, nombre: "Categoria 3", tipo: "Tipo 3-2", imagen: "https://www.becas-santander.com/content/dam/becasmicrosites/blog/trabajos-del-futuro.jpg"));
        listFromApi.append(Categoria(id: 4, idCategoria: 3, nombre: "Categoria 3", tipo: "Tipo 3-3", imagen: "https://www.becas-santander.com/content/dam/becasmicrosites/blog/trabajos-del-futuro.jpg"));
    }
}
