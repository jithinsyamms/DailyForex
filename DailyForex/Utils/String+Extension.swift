//
//  String+Extension.swift
//  DailyForex
//
//  Created by Jithin on 03/01/22.
//

import Foundation

extension String {

    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
