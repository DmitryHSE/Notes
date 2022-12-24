//
//  MainView.swift
//  Notes
//
//  Created by Dmitry on 21.12.2022.
//

import UIKit

final class MainRootView: BaseView {
    
    lazy var notesTableView = NotesTableView()
    
    override func configureAppearance() {
        backgroundColor = .white
       
    }
    
    override func configureUI() {
        addSubView()
        NSLayoutConstraint.activate([
            notesTableView.topAnchor.constraint(equalTo: topAnchor),
            notesTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            notesTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            notesTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            
        ])
    }
}


private extension MainRootView {
    func addSubView() {
        [notesTableView].forEach { addView($0) }
    }
}
