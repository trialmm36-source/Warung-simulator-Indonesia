
extends Node

signal inventory_changed

var food_stock: Dictionary = {
    "nasi_putih": 0,
    "ayam_goreng": 0,
    "telur_dadar": 0,
    "tempe_orek": 0,
    "sambal": 0,
    "sayur": 0,
    "ikan_goreng": 0
}


func add_food(food_name: String, amount: int) -> void:
    if not food_stock.has(food_name) or amount <= 0:
        return

    food_stock[food_name] += amount
    inventory_changed.emit()


func remove_food(food_name: String, amount: int) -> bool:
    if not food_stock.has(food_name):
        return false

    if amount <= 0 or food_stock[food_name] < amount:
        return false

    food_stock[food_name] -= amount
    inventory_changed.emit()
    return true


func get_food_stock(food_name: String) -> int:
    return food_stock.get(food_name, 0)


func get_all_stock() -> Dictionary:
    return food_stock.duplicate()
