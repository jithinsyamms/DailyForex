//
//  BackgroundView.swift
//  DailyForex
//
//  Created by Jithin on 03/01/22.
//

import UIKit

class BackgroundView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit(){
        Bundle.main.loadNibNamed("BackgroundView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
    
    func setLoading(){
        activityIndicator.isHidden = false
        errorLabel.isHidden = true
    }
    
    func setLoadingCompleted(){
        activityIndicator.isHidden = true
        errorLabel.isHidden = true
    }
    
    func setLoadingError(){
        activityIndicator.isHidden = true
        errorLabel.isHidden = false
    }

}
