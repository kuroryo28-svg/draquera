extends Node2D

var player_hp = 30
var enemy_hp = 20
var enemy_name = "Slime"
var message = "Slime appeared!"
var turn = "player"

func _ready() -> void:
	RenderingServer.set_default_clear_color(Color(0.0, 0.0, 0.2))
	queue_redraw()

func _draw() -> void:
	var f = ThemeDB.fallback_font
	draw_rect(Rect2(20, 20, 600, 400), Color(0.1, 0.1, 0.3))
	draw_rect(Rect2(20, 20, 600, 400), Color.WHITE, false, 2)
	draw_circle(Vector2(540, 150), 50, Color(0.8, 0.2, 0.2))
	draw_string(f, Vector2(40, 100), enemy_name, HORIZONTAL_ALIGNMENT_LEFT, -1, 24, Color.WHITE)
	draw_string(f, Vector2(40, 130), "HP: " + str(enemy_hp), HORIZONTAL_ALIGNMENT_LEFT, -1, 20, Color.RED)
	draw_string(f, Vector2(40, 300), "My HP: " + str(player_hp), HORIZONTAL_ALIGNMENT_LEFT, -1, 20, Color.GREEN)
	draw_string(f, Vector2(40, 350), message, HORIZONTAL_ALIGNMENT_LEFT, -1, 20, Color.YELLOW)
	if turn == "player":
		draw_string(f, Vector2(40, 390), "[Z]Fight  [X]Run", HORIZONTAL_ALIGNMENT_LEFT, -1, 18, Color.WHITE)

func _input(event: InputEvent) -> void:
	if turn != "player":
		return
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_Z:
				_attack()
			KEY_X:
				_escape()

func _attack() -> void:
	var dmg = randi_range(5, 12)
	enemy_hp -= dmg
	message = "Hit! " + str(dmg) + " damage!"
	if enemy_hp <= 0:
		message = "Enemy defeated! Press Enter"
		turn = "won"
	else:
		turn = "enemy"
		queue_redraw()
		await get_tree().create_timer(1.0).timeout
		_enemy_turn()
	queue_redraw()

func _enemy_turn() -> void:
	var dmg = randi_range(3, 8)
	player_hp -= dmg
	message = "Enemy attack! " + str(dmg) + " damage!"
	if player_hp <= 0:
		message = "You lost... Press Enter"
		turn = "lost"
	else:
		turn = "player"
	queue_redraw()

func _escape() -> void:
	message = "Escaped!"
	queue_redraw()
	await get_tree().create_timer(0.8).timeout
	get_tree().change_scene_to_file("res://field.tscn")

func _process(_delta: float) -> void:
	if turn in ["won", "lost"]:
		if Input.is_action_just_pressed("ui_accept"):
			get_tree().change_scene_to_file("res://field.tscn")
