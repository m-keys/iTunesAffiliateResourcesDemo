//
//  DetailViewController.swift
//  iTunesAffiliateResources
//
//  Created by Александр Макаров on 06.11.2018.
//  Copyright © 2018 Александр Макаров. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var detailItems: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL (string: "\(detailItems)")
        let requestObj = URLRequest(url: url!)
        webView.load(requestObj)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
