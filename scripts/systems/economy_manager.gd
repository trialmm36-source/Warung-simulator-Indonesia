
extends Node

signal money_changed(new_balance: int)

const SAVE_PATH := "user://player_money.json"

var money: int = 500000


func _ready() -> void:
    load_money()


func add_money(amount: int) -> void:
    if amount <= 0:
        return

    money += amount
    save_money()
    money_changed.emit(money)


func spend_money(amount: int) -> bool:
    if amount <= 0 or amount > money:
        return false

    money -= amount
    save_money()
    money_changed.emit(money)
    return true


func get_balance() -> int:
    return money


func set_balance(amount: int) -> void:
    money = max(0, amount)
    save_money()
    money_changed.emit(money)


func save_money() -> void:
    var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)

    if file == null:
        push_error("Gagal menyimpan uang pemain.")
        return

    file.store_string(str(money))


func load_money() -> void:
    if not FileAccess.file_exists(SAVE_PATH):
        return

    var file := FileAccess.open(SAVE_PATH, FileAccess.READ)

    if file == null:
        push_error("Gagal membaca uang pemain.")
        return

    var saved_money := file.get_as_text().to_int()
    money = max(0, saved_money)
    money_changed.emit(money)
