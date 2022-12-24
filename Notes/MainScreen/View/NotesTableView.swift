//
//  TableView.swift
//  Notes
//
//  Created by Dmitry on 21.12.2022.
//

import UIKit

final class NotesTableView: UITableView {
    
    
    // MARK: - Initialization
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Private Methods

private extension NotesTableView {
    
    func configureAppearance() {
        backgroundColor = .none
    }
}
