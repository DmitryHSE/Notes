//
//  ViewController.swift
//  Notes
//
//  Created by Dmitry on 21.12.2022.
//

import UIKit
import CoreData

class ViewController:BaseViewController<MainRootView>  {
    
    private var dataManager = DataManager()
    private var dataModelsArray = [DataModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupAddButton()
        setupNavigationBar()
        loadDataFromCoreData()
    }
}

// MARK: - Setup UI elements

extension ViewController {
    
    private func setupTableView() {
        mainView.notesTableView.delegate = self
        mainView.notesTableView.dataSource = self
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        mainView.notesTableView.register(nib, forCellReuseIdentifier: TableViewCell.identifier)
        
    }
    
    private func setupNavigationBar() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithDefaultBackground()
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Bradley Hand", size: 32)!]
        title = "My notes"
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.compactAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }
}

// MARK: Add new note button settings

extension ViewController {
    
    private func setupAddButton() {
        let button = UIBarButtonItem(barButtonSystemItem: .add,
                                     target: self,
                                     action: #selector(performAdd(sender:)))
        button.tintColor = .black
        navigationItem.rightBarButtonItem = button
    }
    
    @objc func performAdd(sender: UIBarButtonItem) {
        let vc = NewNoteViewController()
        vc.passDataModelDelegate = self
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

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
        vc.dataModelIndex = indexPath.row
        vc.mainView.textBodyView.isEditable = false
        vc.mainView.headerView.isEditable = false
        vc.updateEditedNotedelegate = self
        self.navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Remove") { _, _, completion in
            self.dataModelsArray.remove(at: indexPath.row)
            self.updateDataAtCoreData(models: self.dataModelsArray)
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

// MARK: - Receive data protocols

extension ViewController: PassDataModelProtocol, UpdateEditedNoteProtocol {
    
    func recieveUpdatedNoteDataModel(datamodel: DataModel, index: Int) {
        dataModelsArray[index] = datamodel
        updateDataAtCoreData(models: dataModelsArray)
        mainView.notesTableView.reloadData()
    }
    
    
    func recieveDataModelFromEditScreen(datamodel: DataModel) {
        dataModelsArray.append(datamodel)
        updateDataAtCoreData(models: dataModelsArray)
        mainView.notesTableView.reloadData()
    }
}

// MARK: - Core data methods

extension ViewController {
    
    private func loadDataFromCoreData() {
        let data = dataManager.readSavedData()
        if data.count > 0 {
            dataModelsArray = data
        } else {
            dataModelsArray = StaticDataModel.DataModelArray
            for i in dataModelsArray {
                dataManager.saveData(h: i.header, t: i.textBody)
            }
        }
    }
    
    private func updateDataAtCoreData(models:[DataModel]) {
        dataManager.deleteAllData()
        for i in models {
            dataManager.saveData(h: i.header, t: i.textBody)
        }
    }
}
