//
//  TableViewCell.swift
//  Notes
//
//  Created by Dmitry on 21.12.2022.
//

import UIKit

class NoteViewCell: UITableViewCell {
    
    static let identifier: String = "Cell"
    var title = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NoteViewCell {
    
    func load(text: Int) {
        let name = String(text)
        title.text = "The number is " + name
    }
}

extension NoteViewCell {
    
    private func config() {
        [title].forEach { item in
            contentView.addView(item)
        }

        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            title.heightAnchor.constraint(equalToConstant: 30)

        ])
    }
}
