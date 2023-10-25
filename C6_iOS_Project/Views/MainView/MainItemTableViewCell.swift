//
//  MainItemTableViewCell.swift
//  C6_iOS_Project
//
//  Created by Sadohu on 22/10/23.
//

import UIKit

class MainItemTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var cvTipos: UICollectionView!
    var listCategoria : [Categoria] = [];
    var onCollectionItemSelect: ((Int, String, String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib();
        cvTipos.dataSource = self;
        cvTipos.delegate = self;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listCategoria.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = cvTipos.dequeueReusableCell(withReuseIdentifier: "tipo", for: indexPath) as! MainTableCollectionViewCell;
        item.tipo.text = listCategoria[indexPath.row].tipo;
        
        let img = listCategoria[indexPath.row].imagen
        CustomConfig.loadImage(fromURL: img, into: item.imagen);
        return item;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItemIdCategoria = listCategoria[indexPath.row].idCategoria;
        let selectedItemCategoria = listCategoria[indexPath.row].nombre;
        let selectedItemTipo = listCategoria[indexPath.row].tipo;
        onCollectionItemSelect?(selectedItemIdCategoria, selectedItemCategoria, selectedItemTipo);
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func resizeImage(_ image : UIImage) -> UIImage{
        let targetSize = CGSize(width: 154, height: 162)

        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { (context) in
            image.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }

}
