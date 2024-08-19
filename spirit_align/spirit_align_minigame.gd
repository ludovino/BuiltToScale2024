extends Minigame

@export var demon_spirit_point_a : Vector2
@export var demon_spirit_point_b : Vector2

@export var demon_spirit_area : Area2D
@export var player_spirit_area : Area2D

var seconds_passed : float

@export var demon_spirit_speed : float
@export var input_sensitivity : float

@export var noise : Noise
@export var initial_demon_color : Color
@export var final_demon_color : Color
var spirit_align_seconds : float

@export var goal_time : float
@export var time_limit : float

var spirits_aligned : bool


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = ProcessMode.PROCESS_MODE_DISABLED
	$DemonSpiritArea.visible = false
	visible = false
	start()

func teardown():
	process_mode = ProcessMode.PROCESS_MODE_DISABLED
	$DemonSpiritArea.visible = false
	visible = false

func start() -> void:
	visible = true
	$DemonSpiritArea.visible = true
	process_mode = PROCESS_MODE_PAUSABLE

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	seconds_passed += delta
	
	#track align progress
	if spirits_aligned:
		spirit_align_seconds += delta
		
	if spirit_align_seconds >= goal_time:
		$DemonSpiritArea/DemonShadow.emitting = false
		succeeded.emit()
		var tween = get_tree().create_tween()
		tween.set_parallel()
		tween.tween_property($DimCam, "modulate", Color.TRANSPARENT, 3.0)
		tween.tween_property(demon_spirit_area, "position",Vector2(230.0, 100.0), 2.0)
		tween.tween_property(player_spirit_area, "position", Vector2(230.0, 100.0), 1.0)
		tween.tween_property(player_spirit_area, "modulate", Color.TRANSPARENT, 1.0)
		tween.chain()
		tween.tween_property(demon_spirit_area, "modulate", Color.TRANSPARENT, 1.0)
		
		return
		
	if seconds_passed >= time_limit:
		failed.emit()
		return
	#demon spirit movement
	
	var lerp_point = (sin(seconds_passed * demon_spirit_speed) / 2) + 0.5
	var lerp_x = noise.get_noise_2d(seconds_passed * demon_spirit_speed, 0) + 0.5
	var lerp_y = noise.get_noise_2d(0, seconds_passed * demon_spirit_speed)	 + 0.5
	
	demon_spirit_area.position.x = lerp(demon_spirit_point_a.x, demon_spirit_point_b.x, lerp_x)
	demon_spirit_area.position.y = lerp(demon_spirit_point_a.y, demon_spirit_point_b.y, lerp_y)
	
	#player spirit control
	var velocity = Input.get_vector("minigame_left", "minigame_right", "minigame_up", "minigame_down") * input_sensitivity
	
	var new_player_pos = Vector2(player_spirit_area.global_position.x + velocity.x,
	player_spirit_area.global_position.y + velocity.y)
	
	new_player_pos.x = clamp(new_player_pos.x, demon_spirit_point_a.x, demon_spirit_point_b.x)
	new_player_pos.y = clamp(new_player_pos.y, demon_spirit_point_a.y, demon_spirit_point_b.y)
	
	if not velocity.is_zero_approx():
		player_spirit_area.look_at(new_player_pos)
	else:
		player_spirit_area.look_at(player_spirit_area.global_position + Vector2.UP)
	player_spirit_area.global_position = new_player_pos
	
	var color_t = 0.5 + fposmod(Time.get_ticks_msec() * 0.001,0.5) if spirits_aligned \
	else spirit_align_seconds / goal_time
	var demon_color : Color = lerp(initial_demon_color, final_demon_color, color_t)
	
	$DemonSpiritArea/DemonShadow.color = demon_color
	$DemonSpiritArea/DemonSprite.modulate = demon_color

func _on_demon_spirit_area_area_entered(area: Area2D) -> void:
	if(area == player_spirit_area):
		spirits_aligned = true
		


func _on_demon_spirit_area_area_exited(area: Area2D) -> void:
	if(area == player_spirit_area):
		spirits_aligned = false
