extends Minigame

@export var demon_spirit_point_a : Vector2
@export var demon_spirit_point_b : Vector2

@export var demon_spirit_area : Area2D
@export var player_spirit_area : Area2D

var seconds_passed : float

@export var demon_spirit_speed : float
@export var input_sensitivity : float

@export var noise : Noise


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#demon spirit movement
	seconds_passed += delta
	var lerp_point = (sin(seconds_passed * demon_spirit_speed) / 2) + 0.5
	var lerp_x = noise.get_noise_2d(seconds_passed * demon_spirit_speed, 0) + 0.5
	var lerp_y = noise.get_noise_2d(0, seconds_passed * demon_spirit_speed)	 + 0.5
	
	#demon_spirit_area.position.x = lerp(demon_spirit_point_a.x, demon_spirit_point_b.x, lerp_point)
	
	demon_spirit_area.position.x = lerp(demon_spirit_point_a.x, demon_spirit_point_b.x, lerp_x)
	demon_spirit_area.position.y = lerp(demon_spirit_point_a.y, demon_spirit_point_b.y, lerp_y)
	
	#player spirit control
	var velocity = Input.get_vector("minigame_left", "minigame_right", "minigame_up", "minigame_down") * input_sensitivity
	
	#player_spirit_area.global_position = Vector2(0.0, 0.0)
	var new_player_pos = Vector2(player_spirit_area.global_position.x + velocity.x,
	player_spirit_area.global_position.y + velocity.y)
	
	new_player_pos.x = clamp(new_player_pos.x, 0.0, 1152.0)
	new_player_pos.y = clamp(new_player_pos.y, 0.0, 648.0)
	
	player_spirit_area.global_position = new_player_pos
	
	#print("[HELLO] demon area x pos: " + str(demon_spirit_area.position.x) + ", seconds passed " + str(seconds_passed) + " lerp point " + str(lerp_point))
	pass
