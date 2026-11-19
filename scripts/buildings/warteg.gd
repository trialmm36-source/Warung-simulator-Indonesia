
extends Node2D

func _draw() -> void:
    # Bayangan bangunan
    draw_ellipse(
        Vector2(0, 155),
        Vector2(255, 75),
        Color("#35452d")
    )

    # Dinding depan
    draw_colored_polygon(
        PackedVector2Array([
            Vector2(-190, -130),
            Vector2(0, -30),
            Vector2(0, 180),
            Vector2(-190, 80)
        ]),
        Color("#e8c99a")
    )

    # Dinding samping
    draw_colored_polygon(
        PackedVector2Array([
            Vector2(0, -30),
            Vector2(190, -130),
            Vector2(190, 80),
            Vector2(0, 180)
        ]),
        Color("#bd9368")
    )

    # Atap utama
    draw_colored_polygon(
        PackedVector2Array([
            Vector2(-240, -140),
            Vector2(0, -270),
            Vector2(240, -140),
            Vector2(0, -5)
        ]),
        Color("#a94332")
    )

    # Bagian atap yang menghadap depan
    draw_colored_polygon(
        PackedVector2Array([
            Vector2(-240, -140),
            Vector2(0, -5),
            Vector2(0, 30),
            Vector2(-240, -105)
        ]),
        Color("#853529")
    )

    # Pintu
    draw_colored_polygon(
        PackedVector2Array([
            Vector2(-115, 10),
            Vector2(-48, 45),
            Vector2(-48, 165),
            Vector2(-115, 130)
        ]),
        Color("#70452e")
    )

    # Jendela depan
    draw_colored_polygon(
        PackedVector2Array([
            Vector2(-180, -55),
            Vector2(-130, -30),
            Vector2(-130, 25),
            Vector2(-180, 0)
        ]),
        Color("#83c8d5")
    )

    # Jendela samping
    draw_colored_polygon(
        PackedVector2Array([
            Vector2(45, 0),
            Vector2(145, -55),
            Vector2(145, -5),
            Vector2(45, 50)
        ]),
        Color("#83c8d5")
    )

    # Papan nama warteg
    draw_colored_polygon(
        PackedVector2Array([
            Vector2(-125, -150),
            Vector2(0, -82),
            Vector2(0, -35),
            Vector2(-125, -100)
        ]),
        Color("#f4df9b")
    )

    draw_string(
        ThemeDB.fallback_font,
        Vector2(-110, -112),
        "WARTEG",
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        24,
        Color("#633b20")
    )

    # Tiang dan detail bangunan
    draw_line(
        Vector2(-190, -130),
        Vector2(-190, 80),
        Color("#805b3d"),
        7
    )

    draw_line(
        Vector2(0, -30),
        Vector2(0, 180),
        Color("#805b3d"),
        7
    )
