//
//  NewsHeaderCell.swift
//  DailyForex
//
//  Created by Jithin on 02/01/22.
//

import UIKit

class NewsHeaderCell: UITableViewCell {

    @IBOutlet weak var forexItemTitle: UILabel!
    @IBOutlet weak var forexItemDescription: UILabel!
    @IBOutlet weak var authorView: AuthorView!
    @IBOutlet weak var rootView: UIStackView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setData(forexItem: ForexItem) {
        forexItemTitle.text = forexItem.title
        forexItemDescription.text = forexItem.description
        authorView.setAuthorDetails(forexItem: forexItem, headerNews: true)
    }
}
