
extends Node

signal purchase_completed(food_id: String, amount: int, total_cost: int)
signal purchase_failed(message: String)


func buy_food(food_id: String, amount: int) -> bool:
	if not FoodData.FOOD_DATA.has(food_id):
		purchase_failed.emit("Makanan tidak ditemukan.")
		return false

	if amount <= 0:
		purchase_failed.emit("Jumlah pembelian tidak valid.")
		return false

	var food: Dictionary = FoodData.get_food(food_id)
	var total_cost: int = food["buy_price"] * amount

	if not EconomyManager.spend_money(total_cost):
		purchase_failed.emit("Uang tidak mencukupi.")
		return false

	InventoryManager.add_food(food_id, amount)

	purchase_completed.emit(food_id, amount, total_cost)
	return true


func get_buy_price(food_id: String) -> int:
	var food: Dictionary = FoodData.get_food(food_id)

	if food.is_empty():
		return 0

	return food["buy_price"]
