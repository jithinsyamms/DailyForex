//
//  ForexResource.swift
//  DailyForex
//
//  Created by Jithin on 01/01/22.
//

import UIKit

struct ForexResource: APIResource {

    typealias Model = Forex
    var scheme: String {
        "https"
    }
    var baseURL: String {
        Constants.BaseURL
    }
    var path: String {
        "/api/v1/dashboard"
    }
    var method: String {
        "GET"
    }
}
