extends Node

@export var animPlayer : AnimationPlayer

var inputDisabled : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	inputDisabled = true
	animPlayer.play("game_over_fade")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(inputDisabled):
		return
	
	if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
		get_tree().change_scene_to_file("res://ui/start_menu_ui/start_menu_ui.tscn")

func enable_controls() -> void:
	inputDisabled = false
