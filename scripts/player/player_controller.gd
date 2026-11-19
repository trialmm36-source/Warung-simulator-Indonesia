
extends CharacterBody2D

@export var move_speed: float = 180.0

var joystick_direction: Vector2 = Vector2.ZERO


func set_joystick_direction(direction: Vector2) -> void:
    joystick_direction = direction.limit_length(1.0)


func _physics_process(_delta: float) -> void:
    var direction := joystick_direction

    if direction == Vector2.ZERO:
        direction = Input.get_vector(
            "ui_left",
            "ui_right",
            "ui_up",
            "ui_down"
        )

    velocity = direction * move_speed
    move_and_slide()
