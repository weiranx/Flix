//
//  MovieDetailsViewController.swift
//  Flix
//
//  Created by Weiran Xiong on 2/19/19.
//  Copyright © 2019 Weiran Xiong. All rights reserved.
//

import UIKit
import WebKit
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
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handlePosterTapped(_:)) )
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        posterView.isUserInteractionEnabled = true
        posterView.addGestureRecognizer(tap)
        
        
        
        
    }
    
    @objc func handlePosterTapped(_ sender: UITapGestureRecognizer) {
        
        // get youtube id
        let apiUrl = URL(string: "https://api.themoviedb.org/3/movie/\(movie["id"]!)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US")!
        
        let request = URLRequest(url: apiUrl, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                let results = dataDictionary["results"] as! NSArray
                let movie = results[0] as! [String: Any]
                let key = movie["key"] as! String
                
                
                let url = URL(string: "https://www.youtube.com/watch?v=\(key))")!
                let request = URLRequest(url: url)
                
                let trailerViewController = TrailerViewController()
                
                
                
                trailerViewController.webView.load(request)
                
                self.navigationController?.pushViewController(trailerViewController, animated: true)
                
            }
        }
        
        task.resume()

    }
    

}



class TrailerViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView = {
        
        let webView = WKWebView()
        
        return webView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()


        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        

        
        let constriants = [
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            webView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            webView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ]

        NSLayoutConstraint.activate(constriants)
    }
    
    

    @objc func done() {
        dismiss(animated: true, completion: nil)
    }
}
