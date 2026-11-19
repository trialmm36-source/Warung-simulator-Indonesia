
extends Node2D

@export var background_texture: Texture2D

func _draw() -> void:
    # Jika background gambar sudah dipasang
    if background_texture != null:
        draw_texture_rect(
            background_texture,
            Rect2(-1200, -540, 2400, 1080),
            false
        )
        return

    # Background sementara jika gambar belum tersedia
    draw_rect(
        Rect2(-3000, -1200, 6000, 2400),
        Color("#8cae65")
    )

    var road := PackedVector2Array([
        Vector2(-3000, -180),
        Vector2(3000, -180),
        Vector2(3000, 180),
        Vector2(-3000, 180)
    ])
    draw_colored_polygon(road, Color("#55585b"))

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

    for x in range(-3000, 3000, 100):
        draw_line(
            Vector2(x, 0),
            Vector2(x + 45, 0),
            Color("#f5e7bd"),
            5.0
        )
