//
//  MovieDetailsViewController.swift
//  Flix
//
//  Created by Weiran Xiong on 2/19/19.
//  Copyright © 2019 Weiran Xiong. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {
    
    var movie: [String: Any]!

    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = movie["title"] as? String
        synopsisLabel.text = movie["overview"] as? String
        
        titleLabel.sizeToFit()
        synopsisLabel.sizeToFit()
        
        // set up poster view
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        
        posterView.af_setImage(withURL: posterUrl!)
        
        
        // set up backdrop view
        let backdropBaseUrl = "https://image.tmdb.org/t/p/w780"
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: backdropBaseUrl + backdropPath)
        
        
        backdropView.af_setImage(withURL: backdropUrl!)
        
        
    }
    

}
