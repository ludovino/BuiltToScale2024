extends Minigame

@export var demon_pov_camera : Camera3D
@export var camera_raycast : RayCast3D

@export var party_member_area_1 : Area3D
@export var party_member_area_2 : Area3D
@export var party_member_area_3 : Area3D

@export var cow_enemy_area : Area3D

var initialised : bool

func _ready() -> void:
	process_mode = ProcessMode.PROCESS_MODE_DISABLED
	visible = false
	$Node2D.visible = false

func start() -> void:
	if !initialised:
		initialised = true
	visible = true
	$Node2D.visible = true
	process_mode = PROCESS_MODE_PAUSABLE

func teardown():
	process_mode = ProcessMode.PROCESS_MODE_DISABLED
	visible = false
	$Node2D.visible = false

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

func _on_teammate_clicked() -> void:
	failed.emit()
	
func _on_enemy_clicked() -> void:
	succeeded.emit()
