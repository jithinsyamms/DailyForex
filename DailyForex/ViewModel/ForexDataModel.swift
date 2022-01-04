//
//  ForexDataModel.swift
//  DailyForex
//
//  Created by Jithin on 01/01/22.
//

import Foundation

protocol ForexDataDelegate: AnyObject {
    func loadingStarted()
    func loadingFinished()
    func errorLoadingData()
}

class ForexDataModel: ObservableObject {

    var forex: Forex?
    var sectionTitles: [String] = ["Breaking News", "Top News", "Daily Briefings",
                                   "Technical Analysis", "Special Report"]
    var sections: [String]  = []
    var forexDict: [String: [ForexItem]] = [:]
    var headerNews: ForexItem?
    var isLoading: Bool = false
    var dataLoadedOnce  = false
    weak var delegate: ForexDataDelegate?

    func fetchForexData() {
        guard !isLoading else {
            return
        }
        isLoading = true
        self.delegate?.loadingStarted()
        let resource = ForexResource()
        let request = ForexRequest(resource: resource)
        request.execute { result in
            switch result {
            case .success(let forex):
                self.dataLoadedOnce = true
                self.forex = forex
                self.setForexData()
            case .failure:
                DispatchQueue.main.async {
                    if !self.dataLoadedOnce {
                        self.delegate?.errorLoadingData()
                    }
                }
            }
            DispatchQueue.main.async {
                self.delegate?.loadingFinished()
                self.isLoading = false
            }
        }
    }

    func setForexData() {
        guard let forex = forex else {
            return
        }
        clearData()
        setBreakingNews(forex: forex)
        setTopNews(forex: forex)
        setDailyBriefings(forex: forex)
        setTechnicalAnalysis(forex: forex)
        setSpecialReports(forex: forex)
    }

    func clearData() {
        sections.removeAll()
        forexDict.removeAll()
        headerNews = nil
    }

    func setBreakingNews(forex: Forex) {
        if var breaking = forex.breakingNews, breaking.count > 0 {
            headerNews = breaking.removeFirst()
            if breaking.count > 0 {
                sections.append(sectionTitles[0])
                forexDict[sectionTitles[0]] = breaking
            }
        }
    }
    func setTopNews(forex: Forex) {
        if var topNews = forex.topNews, topNews.count > 0 {
            if headerNews == nil {
                headerNews = topNews.removeFirst()
            }
            if topNews.count > 0 {
                sections.append(sectionTitles[1])
                forexDict[sectionTitles[1]] = topNews
            }
        }
    }
    func setDailyBriefings(forex: Forex) {

        var briefings: [ForexItem] = []
        if let euData = forex.dailyBriefings.euData {
            briefings.append(contentsOf: euData)
        }
        if let asia = forex.dailyBriefings.asia {
            briefings.append(contentsOf: asia)
        }
        if let usData = forex.dailyBriefings.usData {
            briefings.append(contentsOf: usData)
        }

        if briefings.count > 0 {
            sections.append(sectionTitles[2])
            forexDict[sectionTitles[2]] = briefings
        }

    }
    func setTechnicalAnalysis(forex: Forex) {
        if let technical = forex.technicalAnalysis, technical.count > 0 {
            sections.append(sectionTitles[3])
            forexDict[sectionTitles[3]] = technical
        }
    }
    func setSpecialReports(forex: Forex) {
        if let special = forex.specialReport, special.count > 0 {
            sections.append(sectionTitles[4])
            forexDict[sectionTitles[4]] = special
        }
    }

    func getForexItems(section: String) -> [ForexItem] {
        if let items = forexDict[section] {
            return items
        }
        return []
    }

    func getFloatingNews() -> ForexItem? {
        return headerNews
    }
}
