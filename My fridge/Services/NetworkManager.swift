//
//  NetworkManager.swift
//  My fridge
//
//  Created by Алексей Исаев on 02.12.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init () {}
    
    func fetchCompetitionsList() async throws -> CompetitionsList {
        var request = URLRequest(
            url: URL(string: "https://v3.football.api-sports.io/leagues")!,
            timeoutInterval: 10.0)
        request.addValue("2d3297ddd732374c7f607d900b0d9c69", forHTTPHeaderField: "x-rapidapi-key")
        request.addValue("v3.football.api-sports.io", forHTTPHeaderField: "x-rapidapi-host")
        request.httpMethod = "GET"

        guard let (data, _) = try? await URLSession.shared.data(for: request) else {
            throw NetworkError.noData
        }
        guard let competitionsList = try? JSONDecoder().decode(CompetitionsList.self, from: data) else {
            throw NetworkError.decodingError
        }
        return competitionsList
    }
        
    func fetchFixturesList(leagueID: Int, currentSeason: Int, fromDate: String, toDate: String) async throws -> FixturesList {
        var request = URLRequest(
            url: URL(string: "https://v3.football.api-sports.io/fixtures?league=\(leagueID)&season=\(currentSeason)&from=\(fromDate)&to=\(toDate)")!,
            timeoutInterval: 10.0)
        request.addValue("2d3297ddd732374c7f607d900b0d9c69", forHTTPHeaderField: "x-rapidapi-key")
        request.addValue("v3.football.api-sports.io", forHTTPHeaderField: "x-rapidapi-host")
        request.httpMethod = "GET"

        guard let (data, _) = try? await URLSession.shared.data(for: request) else {
            throw NetworkError.noData
        }
        guard let fixturesList = try? JSONDecoder().decode(FixturesList.self, from: data) else {
            throw NetworkError.decodingError
        }
        return fixturesList
    }
    
    func fetchStatistics(fixtureID: Int) async throws  -> StatisticsData {
        var request = URLRequest(
            url: URL(string: "https://v3.football.api-sports.io/predictions?fixture=\(fixtureID)")!,
            timeoutInterval: 10.0)
        request.addValue("2d3297ddd732374c7f607d900b0d9c69", forHTTPHeaderField: "x-rapidapi-key")
        request.addValue("v3.football.api-sports.io", forHTTPHeaderField: "x-rapidapi-host")
        request.httpMethod = "GET"
        
        guard let (data, _) = try? await URLSession.shared.data(for: request) else {
            throw NetworkError.noData
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let statistics = try? decoder.decode(StatisticsData.self, from: data) else {
            throw NetworkError.decodingError
        }
        return statistics
    }
}
