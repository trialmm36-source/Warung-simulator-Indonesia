
extends Node

signal display_case_changed

const SAVE_PATH := "user://display_case.json"

var displayed_food: Dictionary = {
    "nasi_putih": 0,
    "ayam_goreng": 0,
    "telur_dadar": 0,
    "tempe_orek": 0,
    "sambal": 0,
    "sayur": 0,
    "ikan_goreng": 0
}


func _ready() -> void:
    load_display_case()


func put_food(food_id: String, amount: int) -> bool:
    if not displayed_food.has(food_id) or amount <= 0:
        return false

    if InventoryManager.get_food_stock(food_id) < amount:
        return false

    if not InventoryManager.remove_food(food_id, amount):
        return false

    displayed_food[food_id] += amount
    save_display_case()
    display_case_changed.emit()
    return true


func remove_food(food_id: String, amount: int) -> bool:
    if not displayed_food.has(food_id) or amount <= 0:
        return false

    if displayed_food[food_id] < amount:
        return false

    displayed_food[food_id] -= amount
    InventoryManager.add_food(food_id, amount)
    save_display_case()
    display_case_changed.emit()
    return true


func get_displayed_food(food_id: String) -> int:
    return displayed_food.get(food_id, 0)


func get_all_displayed_food() -> Dictionary:
    return displayed_food.duplicate()


func save_display_case() -> void:
    var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)

    if file == null:
        push_error("Gagal menyimpan etalase.")
        return

    file.store_string(JSON.stringify(displayed_food))


func load_display_case() -> void:
    if not FileAccess.file_exists(SAVE_PATH):
        return

    var file := FileAccess.open(SAVE_PATH, FileAccess.READ)

    if file == null:
        push_error("Gagal membaca etalase.")
        return

    var loaded: Variant = JSON.parse_string(file.get_as_text())

    if not loaded is Dictionary:
        return

    for food_id in displayed_food:
        if loaded.has(food_id):
            displayed_food[food_id] = max(0, int(loaded[food_id]))

    display_case_changed.emit()
