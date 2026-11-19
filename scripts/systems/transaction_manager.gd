
extends Node

signal transaction_started(total: int, payment: int)
signal change_updated(remaining: int)
signal transaction_completed(change: int)

const BANKNOTES: Array[int] = [
    1000, 2000, 5000, 10000, 20000, 50000, 100000
]

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

    var required_change := payment - total
    change_updated.emit(required_change)

    if required_change == 0:
        complete_transaction()

    return true


func give_change(amount: int) -> bool:
    if not transaction_active:
        return false

    if not BANKNOTES.has(amount):
        return false

    var required_change := customer_payment - order_total
    var new_change := change_given + amount

    if new_change > required_change:
        return false

    change_given = new_change
    var remaining := required_change - change_given
    change_updated.emit(remaining)

    if remaining == 0:
        complete_transaction()

    return true


func complete_transaction() -> void:
    transaction_active = false
    transaction_completed.emit(change_given)


func cancel_transaction() -> void:
    transaction_active = false
    order_total = 0
    customer_payment = 0
    change_given = 0
    change_updated.emit(0)
