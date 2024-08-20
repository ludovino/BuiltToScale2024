extends Minigame

@export var meter_deplete_per_second : float
@export var button_press_increment : float
@export var button_meter_goal : float

var current_hell_meter : float

var seconds_passed : float
var current_size : float = 0.0

@export var time_limit : float
@export var hell_mouth : Node3D
@export var hell_mouth_max_size : float


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = ProcessMode.PROCESS_MODE_DISABLED
	visible = false

func start() -> void:
	visible = true
	process_mode = PROCESS_MODE_PAUSABLE
	$Label.visible = true

func teardown():
	process_mode = ProcessMode.PROCESS_MODE_DISABLED
	visible = false
	$Label.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	seconds_passed += delta

	_updateInput(delta)
	current_size = lerpf(current_hell_meter / button_meter_goal, current_size ,exp(-1.0 * delta))
	var rumble_volume = lerpf(-20.0, 0.0, current_size)
	if current_size > 0:
		hell_mouth.visible = true
		var scale = max(current_size * hell_mouth_max_size, 0.01)
		hell_mouth.scale = Vector3.ONE * scale
		$Rumble.volume_db = rumble_volume
	else:
		hell_mouth.scale = Vector3.ONE * 0.01
		hell_mouth.visible = false
	
	if seconds_passed >= time_limit:
		failed.emit()
	pass
	
	

func _updateInput(delta : float) -> void:
	var meter_deplete_this_frame = meter_deplete_per_second * delta
	current_hell_meter -= meter_deplete_this_frame
	current_hell_meter = max(0, current_hell_meter)
	if(Input.is_action_just_pressed("minigame_button_1")):
		current_hell_meter += button_press_increment
	if(current_hell_meter >= button_meter_goal):
		succeeded.emit()
