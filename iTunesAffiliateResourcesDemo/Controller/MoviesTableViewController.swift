//
//  MoviesTableViewController.swift
//  iTunesAffiliateResources
//
//  Created by Александр Макаров on 06.11.2018.
//  Copyright © 2018 Александр Макаров. All rights reserved.
//

import UIKit
import AlamofireImage

class MoviesTableViewController: UITableViewController {
    
    let jsonMoviesURL = URL(string: "https://itunes.apple.com/search")
    
    var movies = [Movie]()
    var artist: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = artist
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.9254902005, green: 0.02894779208, blue: 0.2827339143, alpha: 1)
        
        let queryMovie = ["term": artist, "entity": "musicVideo"]

        if let urlMovie = jsonMoviesURL?.withQueries(queryMovie as! [String : String]) {
            if let data = try? Data(contentsOf: urlMovie) {
                parseJsonMovies(json: data)
            }
        }
        print(movies)
    }
    
    func parseJsonMovies(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonMovies = try? decoder.decode(Movies.self, from: json) {
            movies = jsonMovies.results
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MoviesTableViewCell

        let movie = movies[indexPath.row]
        let url = URL(string: "\(movie.artworkUrl100)")!
        //let placeholderImage = UIImage(named: "blank-pizza")!
        
        //cell.popularProductImage.image = placeholderImage
        cell.imageThumb.af_setImage(withURL: url)
        
        cell.artistName.text = movie.artistName
        cell.trackName.text = movie.trackName

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DetailViewController,
            let indexPaths = self.tableView?.indexPathsForSelectedRows,
            let indexPath = indexPaths.first {
            let item = movies[indexPath.row]
            vc.detailItems = item.previewUrl!
        }
    }

}
