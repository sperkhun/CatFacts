//
//  CatFactsViewController.swift
//  CatFacts
//
//  Created by Serhii PERKHUN on 1/7/19.
//  Copyright © 2019 Serhii PERKHUN. All rights reserved.
//

import UIKit

class CatFactsViewController: UIViewController {
    
    var catFacts = [All]()
    let request = Request()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        makeRequest()
    }

    @IBAction func logOutButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "segueFromCatFactsToLogin", sender: nil)
    }
    
    func makeRequest() {
        
        request.getFacts() { (result) in
            switch result {
            case .success(let facts):
                DispatchQueue.main.async {
                    self.catFacts = facts.all!
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.showAlert(message: "Uh oh, something has gone wrong. Please, try it later.")
                }
            }
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        self.present(alert, animated: true)
        let when = DispatchTime.now() + 3
        DispatchQueue.main.asyncAfter(deadline: when){
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
}

extension CatFactsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catFacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "catFactCell") as! TableViewCell
        if let first = catFacts[indexPath.row].user?.name?.first {
            cell.name.text = first
        }
        if let last = catFacts[indexPath.row].user?.name?.last {
            cell.name.text = cell.name.text! + " \(last)"
        }
        cell.fact.text = catFacts[indexPath.row].text
        return cell
    }
}
