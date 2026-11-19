
extends Node2D

signal location_changed(location_name: String)

var current_location: String = "rumah"

var available_locations: Array[String] = [
    "rumah",
    "peternakan",
    "warteg_luar",
    "pasar"
]


func _ready() -> void:
    print("Warteg Simulator Indonesia: game manager loaded.")
    print("Lokasi awal: ", current_location)


func change_location(location_name: String) -> void:
    if not available_locations.has(location_name):
        push_warning("Lokasi tidak ditemukan: " + location_name)
        return

    current_location = location_name
    location_changed.emit(current_location)

    print("Pemain berpindah ke: ", current_location)


func get_current_location() -> String:
    return current_location
