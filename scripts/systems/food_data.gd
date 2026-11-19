
extends RefCounted

const FOOD_DATA := {
    "nasi_putih": {
        "name": "Nasi Putih",
        "buy_price": 4000,
        "sell_price": 5000
    },
    "ayam_goreng": {
        "name": "Ayam Goreng",
        "buy_price": 8000,
        "sell_price": 11000
    },
    "telur_dadar": {
        "name": "Telur Dadar",
        "buy_price": 4000,
        "sell_price": 6000
    },
    "tempe_orek": {
        "name": "Tempe Orek",
        "buy_price": 3000,
        "sell_price": 4500
    },
    "sambal": {
        "name": "Sambal",
        "buy_price": 1000,
        "sell_price": 2000
    },
    "sayur": {
        "name": "Sayur",
        "buy_price": 2500,
        "sell_price": 4000
    },
    "ikan_goreng": {
        "name": "Ikan Goreng",
        "buy_price": 6500,
        "sell_price": 9000
    }
}


static func get_food(food_id: String) -> Dictionary:
    return FOOD_DATA.get(food_id, {}).duplicate()


static func get_all_food() -> Dictionary:
    return FOOD_DATA.duplicate(true)
