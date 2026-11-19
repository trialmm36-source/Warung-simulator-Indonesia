
extends Node

signal prices_changed

var selling_prices: Dictionary = {}


func _ready() -> void:
    for food_id in FoodData.FOOD_DATA:
        selling_prices[food_id] = FoodData.FOOD_DATA[food_id]["sell_price"]


func get_selling_price(food_id: String) -> int:
    return selling_prices.get(food_id, 0)


func set_selling_price(food_id: String, new_price: int) -> bool:
    if not FoodData.FOOD_DATA.has(food_id):
        return false

    if new_price < 500 or new_price > 100000:
        return false

    selling_prices[food_id] = new_price
    prices_changed.emit()
    return true


func get_all_prices() -> Dictionary:
    return selling_prices.duplicate()
