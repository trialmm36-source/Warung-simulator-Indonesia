
extends Node

signal transaction_started(total: int, payment: int)
signal change_updated(remaining: int)
signal transaction_completed(change: int)

var order_total: int = 0
var customer_payment: int = 0
var change_given: int = 0
var transaction_active: bool = false


func start_transaction(total: int, payment: int) -> bool:
    if transaction_active or total <= 0 or payment < total:
        return false

    order_total = total
    customer_payment = payment
    change_given = 0
    transaction_active = true

    transaction_started.emit(total, payment)
    change_updated.emit(payment - total)
    return true


func give_change(amount: int) -> bool:
    if not transaction_active or amount <= 0:
        return false

    change_given += amount

    var remaining := customer_payment - order_total - change_given
    change_updated.emit(remaining)

    if remaining == 0:
        transaction_active = false
        transaction_completed.emit(change_given)
        return true

    if remaining < 0:
        change_given -= amount
        change_updated.emit(customer_payment - order_total - change_given)
        return false

    return true


func cancel_transaction() -> void:
    transaction_active = false
    order_total = 0
    customer_payment = 0
    change_given = 0

