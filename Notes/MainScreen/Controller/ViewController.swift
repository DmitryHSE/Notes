//
//  ViewController.swift
//  Notes
//
//  Created by Dmitry on 21.12.2022.
//

import UIKit

class ViewController:BaseViewController<MainRootView>  {
    
    private var dataModelsArray = [DataModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupAddButton()
        setupNavigationBar()
    }
}

extension ViewController {
    
    private func setupTableView() {
        //mainView.notesTableView.separatorColor = .clear
        mainView.notesTableView.delegate = self
        mainView.notesTableView.dataSource = self
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        mainView.notesTableView.register(nib, forCellReuseIdentifier: TableViewCell.identifier)
        
    }
    
    private func setupNavigationBar() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithDefaultBackground()
        //navigationBarAppearance.backgroundColor = .systemMint
        title = "Notes"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.compactAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }
}

extension ViewController {
    
    private func setupAddButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(performAdd(sender:)))
    }
    
    @objc func performAdd(sender: UIBarButtonItem) {
        let vc = NewNoteViewController()
        vc.passDataModelDelegate = self
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
        print("Add new note")
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModelsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier) as! TableViewCell
        cell.load(dataModel: dataModelsArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailedNoteViewController()
        vc.dataModel = dataModelsArray[indexPath.row]
        vc.mainView.textBodyView.isEditable = false
        vc.mainView.headerView.isEditable = false
        //vc.passDataModelDelegate = self
        self.navigationController?.pushViewController(vc, animated: true)
        print("Did selected")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension ViewController: PassDataModelProtocol {
    
    func recieveDataModelFromEditScreen(datamodel: DataModel) {
        dataModelsArray.append(datamodel)
        mainView.notesTableView.reloadData()
    }
    
    
}
