
extends Node

signal prices_changed

const SAVE_PATH := "user://selling_prices.json"

var selling_prices: Dictionary = {}


func _ready() -> void:
    for food_id in FoodData.FOOD_DATA:
        selling_prices[food_id] = FoodData.FOOD_DATA[food_id]["sell_price"]

    load_prices()


func get_selling_price(food_id: String) -> int:
    return selling_prices.get(food_id, 0)


func set_selling_price(food_id: String, new_price: int) -> bool:
    if not FoodData.FOOD_DATA.has(food_id):
        return false

    if new_price < 500 or new_price > 100000:
        return false

    selling_prices[food_id] = new_price
    save_prices()
    prices_changed.emit()
    return true


func get_all_prices() -> Dictionary:
    return selling_prices.duplicate()


func save_prices() -> void:
    var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)

    if file == null:
        push_error("Gagal menyimpan harga jual.")
        return

    file.store_string(JSON.stringify(selling_prices))


func load_prices() -> void:
    if not FileAccess.file_exists(SAVE_PATH):
        return

    var file := FileAccess.open(SAVE_PATH, FileAccess.READ)

    if file == null:
        push_error("Gagal membaca harga jual.")
        return

    var loaded: Variant = JSON.parse_string(file.get_as_text())

    if not loaded is Dictionary:
        return

    for food_id in FoodData.FOOD_DATA:
        if loaded.has(food_id):
            var saved_price: int = int(loaded[food_id])

            if saved_price >= 500 and saved_price <= 100000:
                selling_prices[food_id] = saved_price

    prices_changed.emit()
