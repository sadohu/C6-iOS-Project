//
//  MainViewController.swift
//  C6_iOS_Project
//
//  Created by Sadohu on 22/10/23.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DataLoadedDelegate {
    @IBOutlet weak var tvCategorias: UITableView!
    @IBOutlet weak var btnMenuAdmin: UIButton!
    var listFromApi : [Categoria] = [];
    var listCategoria : [Categoria] = [];
    var ids : [Int] = [];
    var nombre : [String] = [];
    var selectedItem : (Int, String, String) = (-1, "", "");
    var userLogged = "";
    
    override func viewDidLoad() {
        super.viewDidLoad();
        tvCategorias.dataSource = self;
        tvCategorias.rowHeight = 200;
        showAdminButton();
    }
    
    func dataLoadedSuccessfully(data: [Categoria]) {
        listFromApi = data;
        listCategoria = CustomConfig.getCategoriasSection(listFromApi);
        ids = [];
        nombre = [];
        dataForCells(listCategoria);
        tvCategorias.reloadData();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        CustomConfig.getCategoriasFromApi(delegate: self);
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @IBAction func btnFind(_ sender: UIButton) {
        // Filtrar
    }
    
    @IBAction func btnNewPost(_ sender: UIButton) {
        performSegue(withIdentifier: "mainPerfilSegue", sender: self);
    }
    
    @IBAction func btnMenuAdmin(_ sender: UIButton) {
        performSegue(withIdentifier: "mainAdminSegue", sender: self);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mainPublicacionSegue" {
            let view = segue.destination as! PublicViewController
            view.cellType = selectedItem;
        }
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
        let tableCell = tvCategorias.dequeueReusableCell(withIdentifier: "tvCellCategoria") as! MainItemTableViewCell;
        let categoryId = self.ids[indexPath.section];
        let listA = listFromApi.filter { $0.idCategoria == categoryId };
        tableCell.listCategoria = [];
        tableCell.listCategoria = listA;
        tableCell.cvTipos.reloadData();
        
        tableCell.onCollectionItemSelect = { [weak self] (selectedIdCategoria, selectedCategoria, selectedTipo) in
            self?.selectedItem = (selectedIdCategoria, selectedCategoria, selectedTipo);
            self?.performSegue(withIdentifier: "mainPublicacionSegue", sender: self);
        }
        
        return tableCell;
    }
    
    func dataForCells(_ list : [Categoria]){
        for id in list{
            self.ids.append(id.idCategoria);
            self.nombre.append(id.nombre)
        }
    }
    
    func showAdminButton(){
        btnMenuAdmin.isHidden = (self.userLogged == "m56SHA4qGvQdu8bhsXuEc32aCeu2") ? false : true;
    }
}
