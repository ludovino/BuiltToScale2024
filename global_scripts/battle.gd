extends Node3D

@export var minigame_scenes: Array[PackedScene]
var minigames: Array[Minigame] = []
var index := 0
var current: Minigame

@export var battle_ui : CanvasItem

func _ready() -> void:
	for scene in minigame_scenes:
		minigames.append(scene.instantiate())
	start()
	
func start() -> void:
	current = minigames[index]
	current.succeeded.connect(next)
	current.failed.connect(game_over)
	battle_ui.visible = !minigames[index].battle_ui_disabled
	add_child(current)

func _teardown_current() -> void:
	current.succeeded.disconnect(next)
	current.failed.disconnect(game_over)
	remove_child(current)
	

func next() -> void:
	_teardown_current()
	index += 1
	if index >= minigames.size():
		print("YOU WIN")
		return
	start()

func game_over() -> void:
	_teardown_current()
	print("GAME OVER")
