//
//  ApiCall.swift
//  MovieApp
//
//  Created by endava on 07.06.2024..
//

import Foundation

class ApiCall{
    
    let apiUrl = "https://five-ios-api.herokuapp.com/api/v1/movie"
    
    struct MovieResp : Decodable{
        
        let id : Int?
        let imageUrl : String?
        let name : String?
        let summary : String?
        let year : Int?
    }
    
    struct crewMember : Decodable{
        let name : String!
        let role : String!
    }
    
    struct MovieRespDetails : Decodable{
        
        let categories : [String]?
        let crewMembers : [crewMember]?
        let duration : Int?
        let id : Int?
        let imageUrl : String?
        let name : String?
        let rating : Double?
        let relDate : String?
        let summary : String?
        let year : Int?
    }
    
    var movies : [MovieResp] = []
    var popular : [MovieResp] = []
    var trending : [MovieResp] = []
    var freeToWatch : [MovieResp] = []
    var detail : MovieRespDetails?
    
    
    func getMovies(from url: String) async throws -> [MovieResp] {
        guard let url = URL(string: url) else { throw URLError(.badURL) }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("Bearer Zpu7bOQYLNiCkT32V3c9BPoxDMfxisPAfevLW6ps", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        let movies = try JSONDecoder().decode([MovieResp].self, from: data)
        
        return movies
    }
        
    func getPopular() async {
        let criteria = ["FOR_RENT", "IN_THEATERS", "ON_TV", "STREAMING"]
        var localPopular: [MovieResp] = []
        
        for criterion in criteria {
            let urlString = "\(apiUrl)/popular?criteria=\(criterion)"
            do {
                let movie = try await getMovies(from: urlString)
                localPopular.append(contentsOf: movie)
            } catch {
                print("Failed to fetch movies: \(error)")
            }
        }
        
        popular.append(contentsOf: localPopular)
        movies.append(contentsOf: localPopular)
    }
    
    func getTrending() async {
        let criteria = ["THIS_WEEK", "TODAY"]
        var localTrending: [MovieResp] = []
        
        for criterion in criteria {
            let urlString = "\(apiUrl)/trending?criteria=\(criterion)"
            do {
                let movie = try await getMovies(from: urlString)
                localTrending.append(contentsOf: movie)
            } catch {
                print("Failed to fetch movies: \(error)")
            }
        }
        
        trending.append(contentsOf: localTrending)
        movies.append(contentsOf: localTrending)
    }
    
    func getFree() async {
        let criteria = ["MOVIE", "TV_SHOW"]
        var localFree: [MovieResp] = []
        
        for criterion in criteria {
            let urlString = "\(apiUrl)/free-to-watch?criteria=\(criterion)"
            do {
                let movie = try await getMovies(from: urlString)
                localFree.append(contentsOf: movie)
            } catch {
                print("Failed to fetch movies: \(error)")
            }
        }
        
        freeToWatch.append(contentsOf: localFree)
        movies.append(contentsOf: localFree)
    }
    
    
    func getAll() async{
        await getFree()
        await getTrending()
        await getPopular()
    }
    
    func getMovieDetails(with url: String) async throws -> MovieRespDetails {
        
        guard let url = URL(string: url) else { throw URLError(.badURL) }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("Bearer Zpu7bOQYLNiCkT32V3c9BPoxDMfxisPAfevLW6ps", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
    
        let movie = try JSONDecoder().decode(MovieRespDetails.self, from: data)
        
        return movie
       
    }
    
    func getDetail(with id: Int) async{
        
        let urlString = "\(apiUrl)/\(id)/details"
        
        do{
            let movie = try await getMovieDetails(with: urlString)
            self.detail = movie
        }
        catch{
            print("Failed to get details")
        }
    }
}
