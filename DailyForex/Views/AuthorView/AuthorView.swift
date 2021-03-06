//
//  AuthorView.swift
//  DailyForex
//
//  Created by Jithin on 01/01/22.
//

import UIKit

class AuthorView: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var authorImage: UIImageView!
    @IBOutlet weak var publishedDate: UILabel!

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    func commonInit() {
        Bundle.main.loadNibNamed("AuthorView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        authorImage.layer.cornerRadius = 20
    }

    func setAuthorDetails(forexItem: ForexItem, headerNews: Bool = false) {
        if let author = forexItem.authors?.first {
            if let photo = author.photo {
                let placeHolder = UIImage(systemName: "star")
                authorImage.loadImageFromURL(urlString: photo, placeholder: placeHolder)
            }
            authorName.text = author.name
            publishedDate.text = formatTime(forexItem: forexItem)
        }

        if headerNews {
            authorName.textColor = UIColor.init(named: "AuthorNameForHeader")
            publishedDate.textColor = UIColor.init(named: "DatePublishedForHeader")
        } else {
            authorName.textColor = UIColor.init(named: "AuthorName")
            publishedDate.textColor = UIColor.init(named: "DatePublished")
        }

    }

    func formatTime(forexItem: ForexItem) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "h:mm a"
        if let displayTime = forexItem.displayTimestamp {
            let publishedTime = displayTime/1000
            let date = Date(timeIntervalSince1970: TimeInterval(publishedTime))
            if Calendar.current.isDateInToday(date) {
                return formatter.string(from: date).lowercased() + ", Today"
            } else if Calendar.current.isDateInYesterday(date) {
                return formatter.string(from: date).lowercased() + ", Yesterday"
            } else {
                formatter.dateFormat = "h:mm a, d MMM YYY"
                return formatter.string(from: date)
            }
        }
        return ""
    }
}
