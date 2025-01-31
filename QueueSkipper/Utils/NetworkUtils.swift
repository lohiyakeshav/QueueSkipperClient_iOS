//
//  NetworkUtils.swift
//  QueueSkipper
//
//  Created by Batch-2 on 28/05/24.
//

import Foundation
import UIKit

class NetworkUtils{
    
    var baseURl = URL(string : "https://queueskipperbackend.onrender.com/")!

    static let shared = NetworkUtils()
    
    enum NetworkUtilsError : Error, LocalizedError {
    case RestaurantNotFound
    case ImageNotFound
    case DishNotFound
    }
    
    func fetchRestaurants() async throws -> [Restaurant]{
        let fetchRestaurantsURL = baseURl.appendingPathComponent("get_All_Restaurant")
        let (data, response) = try await URLSession.shared.data(from: fetchRestaurantsURL)
        
        if let string = String(data: data, encoding: .utf8){
            print(string)
        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkUtilsError.RestaurantNotFound
        }
        print(httpResponse)
        let decoder = JSONDecoder()
        let restaurantListResponse = try decoder.decode(RestaurantsResponse.self, from: data)
        print(restaurantListResponse)
        return restaurantListResponse.restaurants
    }
    
    func fetchTopPicks() async throws -> [Dish]{
        let fetchRestaurantsURL = baseURl.appendingPathComponent("top-picks")
        let (data, response) = try await URLSession.shared.data(from: fetchRestaurantsURL)
        
        if let string = String(data: data, encoding: .utf8){
            print(string)
        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkUtilsError.RestaurantNotFound
        }
        print(httpResponse)
        let decoder = JSONDecoder()
        let restaurantListResponse = try decoder.decode(TopPicks.self, from: data)
        print(restaurantListResponse)
        return restaurantListResponse.allTopPicks
    }
    
    func fetchDish(from url: URL) async throws -> [Dish] {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let string = String(data: data, encoding: .utf8){
            print(string)
        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkUtilsError.DishNotFound
        }
        let decoder = JSONDecoder()
        let userResponse = try decoder.decode(DishResponse.self, from: data)
        return userResponse.products

    }
//    
    func fetchImage(from url: URL) async throws -> UIImage {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let string = String(data: data, encoding: .utf8){
            print(string)
        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkUtilsError.ImageNotFound
        }
        guard let image = UIImage(data: data) else {
            throw NetworkUtilsError.ImageNotFound
        }
        print("chalagya")
        print(image)
        return image
    }
    
    func submitOrder(order: Order) async throws {
        let submitOrderURL = baseURl.appendingPathComponent("order-placed")
        var request = URLRequest(url: submitOrderURL)
        print("Order Placed")
        print(order)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(order)
        request.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let string = String(data: data, encoding: .utf8){
            //print("Order Placed")
            print(string)
        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 202 else {
            throw NetworkUtilsError.RestaurantNotFound
        }
        
        
    }
    
}


