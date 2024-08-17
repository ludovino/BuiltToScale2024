extends Minigame

@export var meter_deplete_per_second : float
@export var button_press_increment : float
@export var button_meter_goal : float

var current_hell_meter : float


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_updateInput(delta)
	pass

func _updateInput(delta : float) -> void:
	var meter_deplete_this_frame = meter_deplete_per_second * delta
	current_hell_meter -= meter_deplete_this_frame
	if(Input.is_action_just_pressed("minigame_button_1")):
		current_hell_meter += button_press_increment
		#print("BRUH pressed the hell button - increment hell energy")
		
	#print("HELLO hell value " + str(current_hell_meter))
	if(current_hell_meter >= button_meter_goal):
		succeeded.emit()
