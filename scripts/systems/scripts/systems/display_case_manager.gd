
extends Node

signal display_case_changed

var displayed_food: Dictionary = {
    "nasi_putih": 0,
    "ayam_goreng": 0,
    "telur_dadar": 0,
    "tempe_orek": 0,
    "sambal": 0,
    "sayur": 0,
    "ikan_goreng": 0
}


func put_food(food_id: String, amount: int) -> bool:
    if not displayed_food.has(food_id) or amount <= 0:
        return false

    if InventoryManager.get_food_stock(food_id) < amount:
        return false

    if not InventoryManager.remove_food(food_id, amount):
        return false

    displayed_food[food_id] += amount
    display_case_changed.emit()
    return true


func remove_food(food_id: String, amount: int) -> bool:
    if not displayed_food.has(food_id) or amount <= 0:
        return false

    if displayed_food[food_id] < amount:
        return false

    displayed_food[food_id] -= amount
    InventoryManager.add_food(food_id, amount)
    display_case_changed.emit()
    return true


func get_displayed_food(food_id: String) -> int:
    return displayed_food.get(food_id, 0)


func get_all_displayed_food() -> Dictionary:
    return displayed_food.duplicate()
