//
//  ForexItemCell.swift
//  DailyForex
//
//  Created by Jithin on 01/01/22.
//

import UIKit

class ForexItemCell: UITableViewCell {

   
    @IBOutlet weak var rootStackView: UIStackView!
    
    @IBOutlet weak var forexItemTitle: UILabel!
    
    @IBOutlet weak var forexItemDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(forexItem:ForexItem){
        forexItemTitle.text = forexItem.title
        forexItemDescription.text = forexItem.description
        rootStackView.layoutIfNeeded()
    }
    
}
