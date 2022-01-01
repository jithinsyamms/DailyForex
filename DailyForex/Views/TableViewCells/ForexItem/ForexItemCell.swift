//
//  ForexItemCell.swift
//  DailyForex
//
//  Created by Jithin on 01/01/22.
//

import UIKit

class ForexItemCell: UITableViewCell {

    @IBOutlet weak var forexItemTitle: UILabel!
    @IBOutlet weak var forexItemDescription: UILabel!
    @IBOutlet weak var authorView: AuthorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(forexItem:ForexItem, isFloating:Bool = false){
        forexItemTitle.text = forexItem.title
        forexItemDescription.text = forexItem.description
        authorView.setAuthorDetails(forexItem: forexItem)
        
        if(isFloating){
            forexItemTitle.textColor = .white
            forexItemDescription.textColor = .white
            
            forexItemTitle.lineBreakMode = .byTruncatingTail
            forexItemTitle.numberOfLines = 3
            
            forexItemTitle.frame.size.height = 200
            forexItemDescription.frame.size.height = 200
            
            forexItemDescription.lineBreakMode = .byTruncatingTail
            forexItemDescription.numberOfLines = 3
        }
        
        layoutIfNeeded()
        
    }
    
}
