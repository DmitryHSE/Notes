//
//  Protocols.swift
//  Notes
//
//  Created by Dmitry on 21.12.2022.
//

import Foundation

protocol PassDataModelProtocol {
    func recieveDataModelFromEditScreen(datamodel:DataModel)
}

protocol UpdateEditedNoteProtocol {
    func recieveUpdatedNoteDataModel(datamodel: DataModel, index: Int)
}
