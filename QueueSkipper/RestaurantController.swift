//
//  RestaurantController.swift
//  QueueSkipper
//
//  Created by Batch-2 on 31/05/24.
//

import Foundation

class RestaurantController {
    
    private var _restaurant : [Restaurant] = []
    
    private var _dish: [Dish] = []
    
    private var _favouriteDish: [Dish] = []
    
    private var _featuredItem: [Dish] = []
    
    private var _featuredMenu: [Dish] = []
    
    private var _cartDish: [Dish] = []
    
    private var _sectionHeaders: [String] = [ "PRLiveFoods", "Featured Items", "Dishes"]
    private var _homeHeaders: [String] = ["Top Picks", "Restaurants"]
    
    static let shared = RestaurantController()
    
    var restaurant: [Restaurant] {
        return _restaurant
    }
    
    var dish: [Dish] {
        return _dish
    }
    
    var favouriteDish: [Dish] {
        return _favouriteDish
    }
    
    var featuredItem: [Dish] {
        return _featuredItem
    }
    
    var featuredMenu: [Dish] {
        return _featuredMenu
    }
    
    var cartDish: [Dish] {
        return _cartDish
    }
    
    var sectionHeaders: [String] {
        return _sectionHeaders
    }
    
    var homeHeaders: [String] {
        return _homeHeaders
    }
    
    init() {
       loadDummyDish()
    }
    func loadDummyDish() {
        let dummyDish: [Dish] = [
            Dish(dishId: "123",image: "big_1", name: "Samosa", description: "Indian dish", price: 17, rating: 4.2, foodType: "Veg", restaurant: "PR LIVE FOODS"),
            Dish(dishId: "234",image: "big_2", name: "Sandwich Pakora", description: "Rohit's Special", price: 35, rating: 4.3, foodType: "Veg", restaurant: "PR LIVE FOODS")
        ]
        _dish = dummyDish
    }
    
    func appendCartDish(dish: Dish) { _cartDish.append(dish) }
    func setRestaurant(restaurant: [Restaurant]) { _restaurant = restaurant }
    func appendFavouriteDish(dish: Dish) { _favouriteDish.append(dish) }
    func removeFavouriteDish(dish: Dish) { _favouriteDish.removeAll{ $0.dishId == dish.dishId } }
    func setCartDishQuantity(index: Int, quantity: Int) { _cartDish[index].quantity = quantity }
    func removeCartDish(at: Int) { _cartDish.remove(at: at) }
}
