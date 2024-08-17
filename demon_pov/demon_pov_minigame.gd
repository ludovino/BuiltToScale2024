extends Minigame

@export var demon_pov_camera : Camera3D



func _ready() -> void:
	pass
	
func _process(delta):
	_update_input(delta)
	
func _update_input(delta) -> void:
	
	
	pass

func _enter_tree() -> void:
	pass

func _exit_tree() -> void:
	pass

func _on_button_pressed() -> void:
	succeeded.emit()

func _on_teammate_clicked() -> void:
	print("FAILURE - you killed your teammate!!")
	failed.emit()
	
func _on_enemy_clicked() -> void:
	print("SUCCESS - you clicked the cow!!")
	succeeded.emit()

func _on_cow_enemy_area_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	var mouseClick = event as InputEventMouseButton
	if(mouseClick and mouseClick.button_index == 1 and mouseClick.pressed):
		_on_enemy_clicked()

func _on_party_member_area_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	var mouseClick = event as InputEventMouseButton
	if(mouseClick and mouseClick.button_index == 1 and mouseClick.pressed):
		_on_teammate_clicked()

func _on_party_member_area_2_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	var mouseClick = event as InputEventMouseButton
	if(mouseClick and mouseClick.button_index == 1 and mouseClick.pressed):
		_on_teammate_clicked()
		
func _on_party_member_area_3_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	var mouseClick = event as InputEventMouseButton
	if(mouseClick and mouseClick.button_index == 1 and mouseClick.pressed):
		_on_teammate_clicked()
