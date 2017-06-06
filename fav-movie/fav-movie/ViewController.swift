//
//  ViewController.swift
//  fav-movie
//
//  Created by kev on 6.06.2017.
//  Copyright © 2017 aniltaskiran. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var favoriteMovies: [Movie] = []
    
    @IBOutlet var mainTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return favoriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let moviecell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath) as! CustomTableViewCell
        
        let idx: Int = indexPath.row
        
        moviecell.movieTittle?.text = favoriteMovies[idx].title
       moviecell.movieYear?.text = favoriteMovies[idx].year
    displayMovieImage(idx, moviecell: moviecell)
        return moviecell
    }
    func displayMovieImage(_ row: Int, moviecell: CustomTableViewCell){
        let url: String = (URL(string: favoriteMovies[row].imageUrl)?.absoluteString)!; URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async(execute: {
                let image = UIImage(data: data!)
                moviecell.moiveImageView?.image = image
                
            })
        }).resume()
    }
    
    override func viewWillAppear(_ animated: Bool) {
      
        mainTableView.reloadData()
    
        if favoriteMovies.count == 0 {
            favoriteMovies.append(Movie(id: "tt032323", title: "Batman Begins", year: "2005", imageUrl: "https://vignette4.wikia.nocookie.net/batman/images/1/1e/Batman_Begins_poster6.jpg/revision/latest?cb=20111218145155"))
        }
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

