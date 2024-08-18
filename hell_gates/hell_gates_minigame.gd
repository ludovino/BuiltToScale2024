extends Minigame

@export var meter_deplete_per_second : float
@export var button_press_increment : float
@export var button_meter_goal : float

var current_hell_meter : float

var seconds_passed : float
@export var time_limit : float


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = ProcessMode.PROCESS_MODE_DISABLED
	visible = false

func start() -> void:
	visible = true
	process_mode = PROCESS_MODE_PAUSABLE
	$Camera3D.make_current()

func teardown():
	process_mode = ProcessMode.PROCESS_MODE_DISABLED
	visible = false
	$Node2D.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	seconds_passed += delta

	_updateInput(delta)
	
	if seconds_passed >= time_limit:
		failed.emit()
	pass

func _updateInput(delta : float) -> void:
	var meter_deplete_this_frame = meter_deplete_per_second * delta
	current_hell_meter -= meter_deplete_this_frame
	current_hell_meter = max(0, current_hell_meter)
	if(Input.is_action_just_pressed("minigame_button_1")):
		current_hell_meter += button_press_increment
		#print("BRUH pressed the hell button - increment hell energy")
		
	#print("HELLO hell value " + str(current_hell_meter))
	if(current_hell_meter >= button_meter_goal):
		succeeded.emit()
