extends Minigame

@export var demon_pov_camera : Camera3D
@export var camera_raycast : RayCast3D

@export var party_member_area_1 : Area3D
@export var party_member_area_2 : Area3D
@export var party_member_area_3 : Area3D

@export var cow_enemy_area : Area3D

func _ready() -> void:
	pass
	
func _process(delta):
	_update_input(delta)
	
func _update_input(delta) -> void:
	if(Input.is_action_just_pressed("minigame_button_1")):
		var object_hit = camera_raycast.get_collider() as Node3D
		if object_hit and object_hit.is_in_group("enemy"):
			_on_enemy_clicked()
		else :
			if object_hit and object_hit.is_in_group(("party")):
				_on_teammate_clicked()

func _enter_tree() -> void:
	pass

func _exit_tree() -> void:
	pass

func _on_button_pressed() -> void:
	pass #succeeded.emit()

func _on_teammate_clicked() -> void:
	failed.emit()
	
func _on_enemy_clicked() -> void:
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
