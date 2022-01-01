//
//  ForexDataModel.swift
//  DailyForex
//
//  Created by Jithin on 01/01/22.
//

import Foundation


class ForexDataModel:ObservableObject{
    
    var forex:Forex?
    var sectionTitles:[String] = ["Breaking News", "Top News", "Daily Briefings","Technical Analysis", "Special Report"]
    var sections:[String]  = []
    var errorOccured:Bool = false
    var forexDict:[String:[ForexItem]] = [:]
    
    init() {
        fetchForexData()
    }
    
    @Published var isLoading:Bool = false
    
    func fetchForexData(){
        guard !isLoading else {
            return
        }
        isLoading = true
        let resource = ForexResource()
        let request = ForexRequest(resource: resource)
        request.execute { result in
            switch result{
            case .success(let forex):
                self.forex = forex
                self.setForexData()
            case .failure( _):
                self.errorOccured = true
            }
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
    }
    
    func setForexData(){
        guard let forex = forex else {
            return
        }
        setBreakingNews(forex: forex)
        setTopNews(forex: forex)
        setDialyBriefings(forex: forex)
        setTechnicalAnalysis(forex: forex)
        setSpecialReports(forex: forex)
    }
    
    func setBreakingNews(forex:Forex){
        if let breaking = forex.breakingNews, breaking.count > 0{
            sections.append(sectionTitles[0])
            forexDict[sectionTitles[0]] = breaking
        }
    }
    func setTopNews(forex:Forex){
        if let topNews = forex.topNews, topNews.count > 0{
            sections.append(sectionTitles[1])
            forexDict[sectionTitles[1]] = topNews
        }
    }
    func setDialyBriefings(forex:Forex){
        
        var briefings:[ForexItem] = []
        if let eu = forex.dailyBriefings.eu{
            briefings.append(contentsOf: eu)
        }
        if let asia = forex.dailyBriefings.asia{
            briefings.append(contentsOf: asia)
        }
        if let us = forex.dailyBriefings.us{
            briefings.append(contentsOf: us)
        }
        
        if briefings.count > 0{
            sections.append(sectionTitles[2])
            forexDict[sectionTitles[2]] = briefings
        }
        
    }
    func setTechnicalAnalysis(forex:Forex){
        if let technical = forex.technicalAnalysis, technical.count > 0{
            sections.append(sectionTitles[3])
            forexDict[sectionTitles[3]] = technical
        }
    }
    func setSpecialReports(forex:Forex){
        if let special = forex.specialReport, special.count > 0{
            sections.append(sectionTitles[4])
            forexDict[sectionTitles[4]] = special
        }
    }
    
    func getForexItems(section:String) -> [ForexItem]{
        if let items = forexDict[section] {
            return items
        }
        return []
    }
}
