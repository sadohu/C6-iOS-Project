//
//  MainItemTableViewCell.swift
//  C6_iOS_Project
//
//  Created by Sadohu on 22/10/23.
//

import UIKit

class MainItemTableViewCell: UITableViewCell, UICollectionViewDataSource {
    
    @IBOutlet weak var cvTipos: UICollectionView!
    var listCategoria : [Categoria] = [];
    @IBOutlet weak var lblCategoria: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib();
        cvTipos.dataSource = self;
        fillData();
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listCategoria.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = cvTipos.dequeueReusableCell(withReuseIdentifier: "tipo", for: indexPath) as! MainTableCollectionViewCell;
        item.tipo.text = listCategoria[indexPath.row].tipo;
        
        
        
       
        
        let img = listCategoria[indexPath.row].imagen
        if let url = URL(string: img) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error al cargar la imagen: \(error)")
                } else if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        item.imagen.image = image;
                    }
                }
            }
            task.resume()
        } else {
            print("Error en tu url manito")
        }
        return item;
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func resizeImage(_ image : UIImage) -> UIImage{
        let targetSize = CGSize(width: 154, height: 162)

        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { (context) in
            image.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
    
    func fillData(){
        listCategoria.append(Categoria(id: 1, idCategoria: 1, nombre: "Categoria 1", tipo: "Tipo 1", imagen: "https://styles.redditmedia.com/t5_8btpsf/styles/communityIcon_achbnr7vdgxa1.png"));
        listCategoria.append(Categoria(id: 2, idCategoria: 1, nombre: "Categoria 2", tipo: "Tipo 2", imagen: "https://styles.redditmedia.com/t5_8btpsf/styles/communityIcon_achbnr7vdgxa1.png"));
        listCategoria.append(Categoria(id: 3, idCategoria: 1, nombre: "Categoria 3", tipo: "Tipo 3", imagen: "https://styles.redditmedia.com/t5_8btpsf/styles/communityIcon_achbnr7vdgxa1.png"));
        listCategoria.append(Categoria(id: 4, idCategoria: 1, nombre: "Categoria 4", tipo: "Tipo 4", imagen: "https://styles.redditmedia.com/t5_8btpsf/styles/communityIcon_achbnr7vdgxa1.png"));
    }

}
