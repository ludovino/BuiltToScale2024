extends Node

@export var animPlayer : AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = PROCESS_MODE_DISABLED
	animPlayer.play("game_over_fade")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("menu_button_1")):
		get_tree().change_scene_to_file("res://battle/battle_scene.tscn")
	if(Input.is_action_just_pressed("menu_button_2")):
		get_tree().quit()

func enable_controls() -> void:
	process_mode = PROCESS_MODE_PAUSABLE
