extends Node3D

@export var minigames: Array[Minigame]
var index := 0
var current: Minigame

@export var battle_ui : CanvasItem

func _ready() -> void:
	start()
	
func start() -> void:
	current = minigames[index]
	current.succeeded.connect(next)
	current.failed.connect(game_over)
	battle_ui.visible = !current.battle_ui_disabled
	current.start()

func _teardown_current() -> void:
	current.succeeded.disconnect(next)
	current.failed.disconnect(game_over)
	current.teardown()

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
