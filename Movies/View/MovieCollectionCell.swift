//
//  MovieCollectionCell.swift
//  Movies
//
//  Created by Faheem Rahman on 15/06/22.
//

import UIKit

class MovieCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var moviewImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    var movieItem:Search? {
        didSet {
            guard let movieItem = movieItem else {return}
            if let name = movieItem.title {
                titleLbl.text = name
            }
            if let movieImage = movieItem.poster {
                moviewImg.setImage(url: movieImage, placeholderImage: UIImage(named: "UserPlaceholder"))
            }
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
