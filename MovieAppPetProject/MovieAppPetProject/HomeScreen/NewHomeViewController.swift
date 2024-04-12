//
//  NewHomeViewController.swift
//  MovieAppPetProject
//
//  Created by Sebastian Jacobs on 2024/04/12.
//

import UIKit
import SDWebImage

class NewHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    private let nowPlayingViewModel = NowPlayingViewModel()
    
    @IBOutlet weak var newTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseTableCell", for: indexPath) as? NewTableViewCell else {
            fatalError("Warra Warra")
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }

}
