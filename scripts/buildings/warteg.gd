
extends Node2D

@export var building_texture: Texture2D

func _ready() -> void:
    queue_redraw()


func _draw() -> void:
    if building_texture != null:
        draw_texture(
            building_texture,
            Vector2(
                -building_texture.get_width() / 2.0,
                -building_texture.get_height() / 2.0
            )
        )
        return

    # Tampilan sementara jika gambar belum dipasang
    draw_colored_polygon(
        PackedVector2Array([
            Vector2(-230, 155),
            Vector2(-180, 115),
            Vector2(0, 95),
            Vector2(180, 115),
            Vector2(230, 155),
            Vector2(180, 195),
            Vector2(0, 215),
            Vector2(-180, 195)
        ]),
        Color("#35452d")
    )
