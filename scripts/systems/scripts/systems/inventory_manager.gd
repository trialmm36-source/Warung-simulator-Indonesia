
extends Node

signal inventory_changed

const SAVE_PATH := "user://food_inventory.json"

var food_stock: Dictionary = {
    "nasi_putih": 0,
    "ayam_goreng": 0,
    "telur_dadar": 0,
    "tempe_orek": 0,
    "sambal": 0,
    "sayur": 0,
    "ikan_goreng": 0
}


func _ready() -> void:
    load_inventory()


func add_food(food_name: String, amount: int) -> void:
    if not food_stock.has(food_name) or amount <= 0:
        return

    food_stock[food_name] += amount
    save_inventory()
    inventory_changed.emit()


func remove_food(food_name: String, amount: int) -> bool:
    if not food_stock.has(food_name):
        return false

    if amount <= 0 or food_stock[food_name] < amount:
        return false

    food_stock[food_name] -= amount
    save_inventory()
    inventory_changed.emit()
    return true


func get_food_stock(food_name: String) -> int:
    return food_stock.get(food_name, 0)


func get_all_stock() -> Dictionary:
    return food_stock.duplicate()


func save_inventory() -> void:
    var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)

    if file == null:
        push_error("Gagal menyimpan inventaris.")
        return

    file.store_string(JSON.stringify(food_stock))


func load_inventory() -> void:
    if not FileAccess.file_exists(SAVE_PATH):
        return

    var file := FileAccess.open(SAVE_PATH, FileAccess.READ)

    if file == null:
        push_error("Gagal membaca inventaris.")
        return

    var loaded: Variant = JSON.parse_string(file.get_as_text())

    if not loaded is Dictionary:
        return

    for food_id in food_stock:
        if loaded.has(food_id):
            food_stock[food_id] = max(0, int(loaded[food_id]))

    inventory_changed.emit()
