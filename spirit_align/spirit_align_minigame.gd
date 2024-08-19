extends Minigame

@export var demon_spirit_point_a : Vector2
@export var demon_spirit_point_b : Vector2

@export var demon_spirit_area : Area2D
@export var player_spirit_area : Area2D

var seconds_passed : float

@export var demon_spirit_speed : float
@export var input_sensitivity : float

@export var noise : Noise

var spirit_align_seconds : float

@export var goal_time : float
@export var time_limit : float

var spirits_aligned : bool

@export var progress_line : TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	progress_line.max_value = goal_time
	process_mode = ProcessMode.PROCESS_MODE_DISABLED
	$DemonSpiritArea.visible = false
	visible = false

func teardown():
	progress_line.max_value = goal_time
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
		
	progress_line.value = spirit_align_seconds
		
	if spirit_align_seconds >= goal_time:
		succeeded.emit()
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
	
	new_player_pos.x = clamp(new_player_pos.x, 0.0, 1152.0)
	new_player_pos.y = clamp(new_player_pos.y, 0.0, 648.0)
	
	player_spirit_area.global_position = new_player_pos


func _on_demon_spirit_area_area_entered(area: Area2D) -> void:
	if(area == player_spirit_area):
		spirits_aligned = true
		


func _on_demon_spirit_area_area_exited(area: Area2D) -> void:
	if(area == player_spirit_area):
		spirits_aligned = false
