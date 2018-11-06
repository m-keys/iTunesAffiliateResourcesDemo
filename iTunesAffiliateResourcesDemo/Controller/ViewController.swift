//
//  ViewController.swift
//  iTunesAffiliateResources
//
//  Created by Александр Макаров on 05.11.2018.
//  Copyright © 2018 Александр Макаров. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let jsonArtistURL = URL(string: "https://itunes.apple.com/lookup")
    
    var artists = [Artist]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Исполнители"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.9254902005, green: 0.02894779208, blue: 0.2827339143, alpha: 1)
        
        parseJsonArtists()
    }
    
    func parseJsonArtists() {
        let queryArtist = ["id": "1372953342,282234226,564657683,367570856", "country": "ru"]
        if let urlArtist = jsonArtistURL?.withQueries(queryArtist) {
            if let data = try? Data(contentsOf: urlArtist) {
                
                let decoder = JSONDecoder()
                
                if let jsonArtists = try? decoder.decode(Artists.self, from: data) {
                    artists = jsonArtists.results
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MoviesTableViewController,
            let indexPaths = self.tableView?.indexPathsForSelectedRows,
            let indexPath = indexPaths.first {
            let item = artists[indexPath.row]
            //let item = artistToDisplayAt(indexPath: indexPath)
            vc.artist = item.artistName
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let artist = artists[indexPath.row]
        
        cell.textLabel?.text = artist.artistName
        cell.textLabel?.textColor = #colorLiteral(red: 0.9254902005, green: 0.02894779208, blue: 0.2827339143, alpha: 1)
        cell.detailTextLabel?.text = artist.primaryGenreName
        
        return cell
    }
}

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        return components?.url
    }
}
