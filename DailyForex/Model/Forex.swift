//
//  Forex.swift
//  DailyForex
//
//  Created by Jithin on 01/01/22.
//

import Foundation

struct Forex: Codable {
    let breakingNews: [ForexItem]?
    let topNews: [ForexItem]?
    let dailyBriefings: DailyBriefings
    let technicalAnalysis: [ForexItem]?
    let specialReport: [ForexItem]?
}
struct DailyBriefings: Codable {
    let euData, asia, usData: [ForexItem]?
    enum CodingKeys: String, CodingKey {
        case euData = "eu"
        case asia
        case usData = "us"
    }
}

struct ForexItem: Codable {
    let title: String?
    let url: String?
    let description: String?
    let content: String?
    let firstImageURL: String?
    let headlineImageURL: String?
    let articleImageURL: String?
    let backgroundImageURL: String?
    let videoType: String?
    let videoID: String?
    let videoURL: String?
    let videoThumbnail: String?
    let newsKeywords: String?
    let authors: [Author]?
    let instruments: [String]?
    let tags: [String]?
    let categories: [String]?
    let displayTimestamp: Int?
    let lastUpdatedTimestamp: Int?

    enum CodingKeys: String, CodingKey {
        case title, url, description
        case content
        case firstImageURL = "firstImageUrl"
        case headlineImageURL = "headlineImageUrl"
        case articleImageURL = "articleImageUrl"
        case backgroundImageURL = "backgroundImageUrl"
        case videoType
        case videoID = "videoId"
        case videoURL = "videoUrl"
        case videoThumbnail, newsKeywords, authors, instruments,
             tags, categories, displayTimestamp, lastUpdatedTimestamp
    }
}

struct Author: Codable {
    let name: String?
    let title: String?
    let bio: String?
    let email: String?
    let phone: String?
    let facebook: String?
    let twitter: String?
    let googleplus: String?
    let subscription: String?
    let rss: String?
    let descriptionLong: String?
    let descriptionShort: String?
    let photo: String?
}
