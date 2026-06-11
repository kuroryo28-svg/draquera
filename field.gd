extends Node2D

var player_pos = Vector2(5, 5)
var tile_size = 32
var map_width = 20
var map_height = 15

func _ready() -> void:
	RenderingServer.set_default_clear_color(Color(0.1, 0.3, 0.1))
	queue_redraw()

func draw_map() -> void:
	queue_redraw()

func draw_player() -> void:
	queue_redraw()

func _draw() -> void:
	for y in range(map_height):
		for x in range(map_width):
			var rect = Rect2(x * tile_size, y * tile_size, tile_size - 1, tile_size - 1)
			draw_rect(rect, Color(0.2, 0.5, 0.2))
	var px = player_pos.x * tile_size
	var py = player_pos.y * tile_size
	draw_rect(Rect2(px + 4, py + 4, tile_size - 8, tile_size - 8), Color.YELLOW)

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		var moved = false
		match event.keycode:
			KEY_UP, KEY_W:
				if player_pos.y > 0:
					player_pos.y -= 1
					moved = true
			KEY_DOWN, KEY_S:
				if player_pos.y < map_height - 1:
					player_pos.y += 1
					moved = true
			KEY_LEFT, KEY_A:
				if player_pos.x > 0:
					player_pos.x -= 1
					moved = true
			KEY_RIGHT, KEY_D:
				if player_pos.x < map_width - 1:
					player_pos.x += 1
					moved = true
		if moved:
			queue_redraw()
			if randf() < 0.2:
				get_tree().change_scene_to_file("res://battle.tscn")
