//
//  DateView.swift
//  DailyForex
//
//  Created by Jithin on 01/01/22.
//

import UIKit

class DateView: UIView {
    
    @IBOutlet var contentView: DateView!
    @IBOutlet weak var datePublished: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit(){
        Bundle.main.loadNibNamed("DateView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
    
    func setDate(forexItem:ForexItem){
        if let date = forexItem.displayTimestamp {
            let dispayData = Date(timeIntervalSince1970: TimeInterval(date))
            let dateString  = format(date: dispayData)
            datePublished.text = dateString
        }
    }
    
    func format(date:Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "H:mm, dd/M/yyyy"
        return formatter.string(from: date)
    }
    
}
