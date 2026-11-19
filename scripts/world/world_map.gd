
extends Node2D

func _draw() -> void:
    # Tanah dasar kampung
    draw_rect(
        Rect2(-3000, -1200, 6000, 2400),
        Color("#8cae65")
    )

    # Jalan aspal horizontal
    var road := PackedVector2Array([
        Vector2(-3000, -180),
        Vector2(3000, -180),
        Vector2(3000, 180),
        Vector2(-3000, 180)
    ])
    draw_colored_polygon(road, Color("#55585b"))

    # Garis tepi jalan
    draw_line(
        Vector2(-3000, -180),
        Vector2(3000, -180),
        Color("#d5c7a3"),
        12.0
    )

    draw_line(
        Vector2(-3000, 180),
        Vector2(3000, 180),
        Color("#d5c7a3"),
        12.0
    )

    # Marka jalan putus-putus
    for x in range(-3000, 3000, 100):
        draw_line(
            Vector2(x, 0),
            Vector2(x + 45, 0),
            Color("#f5e7bd"),
            5.0
        )
