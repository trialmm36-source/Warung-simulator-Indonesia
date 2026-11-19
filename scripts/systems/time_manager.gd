
extends Node

signal time_changed
signal new_day_started

@export_range(0, 23) var start_hour: int = 6
@export_range(0, 59) var start_minute: int = 0
@export var game_minutes_per_real_second: float = 1.0

var day: int = 1
var hour: int
var minute: int
var time_accumulator: float = 0.0


func _ready() -> void:
    hour = start_hour
    minute = start_minute


func _process(delta: float) -> void:
    time_accumulator += delta * game_minutes_per_real_second

    while time_accumulator >= 1.0:
        time_accumulator -= 1.0
        advance_time(1)


func advance_time(minutes: int) -> void:
    var total_minutes := hour * 60 + minute + minutes

    while total_minutes >= 1440:
        total_minutes -= 1440
        day += 1
        new_day_started.emit()

    hour = total_minutes / 60
    minute = total_minutes % 60

    time_changed.emit()


func sleep_until_morning() -> void:
    if hour >= 6 and hour < 18:
        day += 1
        new_day_started.emit()

    hour = 6
    minute = 0
    time_accumulator = 0.0

    time_changed.emit()


func get_time_text() -> String:
    return "%02d:%02d" % [hour, minute]


func get_time_period() -> String:
    if hour >= 6 and hour < 11:
        return "Pagi"
    elif hour >= 11 and hour < 18:
        return "Siang"
    return "Malam"
