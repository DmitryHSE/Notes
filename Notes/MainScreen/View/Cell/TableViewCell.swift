//
//  TableViewCell.swift
//  Notes
//
//  Created by Dmitry on 21.12.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let identifier: String = "NewCell"

    @IBOutlet weak var textBody: UILabel!
    @IBOutlet weak var header: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}

extension TableViewCell {
    
    func load(dataModel: DataModel) {
        header.text = dataModel.header
        textBody.text = dataModel.textBody
    }
}
