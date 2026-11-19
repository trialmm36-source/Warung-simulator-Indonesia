extends Node

const SAVE_PATH := "user://save_slot_1.json"

func save_dictionary(data: Dictionary) -> bool:
    var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
    if file == null:
        push_error("Tidak bisa membuka file penyimpanan.")
        return false
    file.store_string(JSON.stringify(data))
    return true

func load_dictionary() -> Dictionary:
    if not FileAccess.file_exists(SAVE_PATH):
        return {}
    var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
    if file == null:
        push_error("Tidak bisa membaca file penyimpanan.")
        return {}
    var parsed: Variant = JSON.parse_string(file.get_as_text())
    if parsed is Dictionary:
        return parsed
    return {}
