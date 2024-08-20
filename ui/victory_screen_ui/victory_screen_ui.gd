extends Control

@export var skit : Array[Control]
var index := 0
var ending = false
@onready var audio := $AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("menu_button_1")):
		if index >= skit.size():
			if ending:
				return
			ending = true
			var tween = get_tree().create_tween()

			tween.tween_property(self, "modulate", Color.TRANSPARENT, 5.0)
			tween.parallel()
			tween.tween_property(audio,"volume_db", -50.0, 5.0)
			tween.tween_interval(2.0)
			tween.tween_callback(_end_game)
			return
		skit[index].visible = true
		index += 1
		
func _end_game():
	get_tree().change_scene_to_file("res://ui/credits_ui/credits_ui.tscn")
