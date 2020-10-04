//
//  CategoriesTVCell.swift
//  JnAPICucknorris
//
//  Created by Jonatan on 04/10/2020.
//

import UIKit
//
// MARK: - CategoriesTVCell
//
class CategoriesTVCell: UITableViewCell {
    
    // MARK: - IBOutlets
    //
    @IBOutlet weak var categorieLabel: UILabel!
    @IBOutlet weak var iconCategorie: UIImageView!
    //
    // MARK: - UITableViewCell
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(named: "Jnblue")!
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    //
    // MARK: - Functions
    //
    func prepareCell(with categorie: String) {
        
        categorieLabel.text = categorie.firstUppercased
        
        iconCategorie.image = UIImage(named:"chuck-norris")
        
    }
    
}

//
// MARK: - Extension String First Mayus
//
extension String {
    var firstUppercased: String {
        guard let first = first else { return "" }
        return String(first).uppercased() + dropFirst()
    }
}
