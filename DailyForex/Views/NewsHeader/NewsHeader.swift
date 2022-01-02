//
//  NewsHeader.swift
//  DailyForex
//
//  Created by Jithin on 02/01/22.
//

import UIKit

class NewsHeader: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var forexItemTitle: UILabel!
    @IBOutlet weak var forexItemDescription: UILabel!
    @IBOutlet weak var authorView: AuthorView!
    @IBOutlet weak var rootView: UIStackView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit(){
        Bundle.main.loadNibNamed("NewsHeader", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
    
    func setData(forexItem:ForexItem){
        forexItemTitle.text = forexItem.title
        forexItemDescription.text = forexItem.description
        authorView.setAuthorDetails(forexItem: forexItem)
    }
}
