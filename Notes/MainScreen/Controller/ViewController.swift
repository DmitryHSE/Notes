//
//  ViewController.swift
//  Notes
//
//  Created by Dmitry on 21.12.2022.
//

import UIKit

class ViewController:BaseViewController<MainRootView>  {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        setupTableView()
    }
}

extension ViewController {
    
    private func setupTableView() {
         //mainView.notesTableView.separatorColor = .clear
         mainView.notesTableView.delegate = self
         mainView.notesTableView.dataSource = self
         mainView.notesTableView.register(NoteViewCell.self, forCellReuseIdentifier: NoteViewCell.identifier)
     }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoteViewCell.identifier) as! NoteViewCell
        cell.load(text: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Did selected")
    }
}
