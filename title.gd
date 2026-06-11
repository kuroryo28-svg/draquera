extends Node2D

func _ready() -> void:
	# 背景色を黒に
	RenderingServer.set_default_clear_color(Color.BLACK)
	
	# タイトルラベル
	var title = Label.new()
	title.text = "DRAQUERA"
	title.add_theme_font_size_override("font_size", 64)
	title.add_theme_color_override("font_color", Color.YELLOW)
	title.set_anchors_preset(Control.PRESET_CENTER_TOP)
	title.position = Vector2(540 - title.size.x / 2, 200)
	add_child(title)
	
	# スタートボタン
	var btn = Button.new()
	btn.text = "はじめる"
	btn.add_theme_font_size_override("font_size", 32)
	btn.size = Vector2(200, 60)
	btn.position = Vector2(440, 400)
	btn.pressed.connect(_on_start)
	add_child(btn)

func _on_start() -> void:
	get_tree().change_scene_to_file("res://field.tscn")
