
extends Node

signal money_changed(new_balance: int)

var money: int = 500000


func add_money(amount: int) -> void:
    if amount <= 0:
        return

    money += amount
    money_changed.emit(money)


func spend_money(amount: int) -> bool:
    if amount <= 0 or amount > money:
        return false

    money -= amount
    money_changed.emit(money)
    return true


func get_balance() -> int:
    return money


func set_balance(amount: int) -> void:
    money = max(0, amount)
    money_changed.emit(money)
