extends Node

@export_range(0, 23) var start_hour: int = 8
@export_range(0, 59) var start_minute: int = 0

var day: int = 1
var hour: int
var minute: int

func _ready() -> void:
    hour = start_hour
    minute = start_minute

func get_time_text() -> String:
    return "%02d:%02d" % [hour, minute]
