extends Node3D

@export var battle_ui : CanvasItem

func _ready():
	start()

func victory() -> void:
	get_tree().change_scene_to_file("res://ui/victory_screen_ui/victory_screen_ui.tscn")

func game_over() -> void:
	get_tree().change_scene_to_file("res://ui/game_over_ui/game_over_ui.tscn")

func start() -> void:
	$AnimationPlayer.play("opening_shot")
	$AnimationPlayer.queue("casting")
	$AnimationPlayer.queue("darken")
	$AnimationPlayer.queue("rune_intro")
	$AnimationPlayer.queue("rune_play")

func _on_rune_book_succeeded() -> void:
	$AnimationPlayer.play("rune_win")
	$AnimationPlayer.queue("gates_intro")
	$AnimationPlayer.queue("gates_play")

func _on_hell_gates_scene_succeeded() -> void:
	$AnimationPlayer.play("gates_win")
	$AnimationPlayer.queue("spirit_intro")
	$AnimationPlayer.queue("spirit_play")

func _on_demon_pov_succeeded() -> void:
	$AnimationPlayer.play("insect_kill")
	$AnimationPlayer.animation_finished.connect(victory)

func _on_spirit_align_succeeded() -> void:
	$AnimationPlayer.play("spirit_win")
	$AnimationPlayer.queue("demon_intro")
	$AnimationPlayer.queue("demon_play")
