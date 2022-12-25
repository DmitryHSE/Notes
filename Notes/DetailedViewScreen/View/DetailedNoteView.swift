//
//  DetailedNoteView.swift
//  Notes
//
//  Created by Dmitry on 22.12.2022.
//

import UIKit

final class DetailedNoteView: BaseView {
    
    var headerView: UITextView = {
       let textView = UITextView()
        textView.backgroundColor = .systemGray6
        textView.layer.cornerRadius = 15
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Avenir Next", size: 25)
        textView.isScrollEnabled = false
        return textView
    }()
    
    var textBodyView: UITextView = {
       let textView = UITextView()
        textView.backgroundColor = .systemGray6
        textView.layer.cornerRadius = 15
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Avenir Next", size: 20)
        return textView
    }()
    
    override func configureUI() {
        addSubView()
        setConstraints()
    }
}

// MARK: - Constraints

extension DetailedNoteView {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            headerView.heightAnchor.constraint(equalToConstant: 45),
            
            textBodyView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10),
            textBodyView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            textBodyView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            textBodyView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
}

private extension DetailedNoteView {
    func addSubView() {
        [headerView, textBodyView].forEach { addView($0) }
    }
}
