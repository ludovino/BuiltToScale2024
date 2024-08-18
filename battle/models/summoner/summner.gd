extends Node3D

@export var cast_fx: PackedScene

func cast() -> void:
	$AnimationPlayer.play("cast2")
	$AnimationPlayer.queue("Idle")
	spawn_cast_fx()

func spawn_cast_fx() -> void:
	var fx = cast_fx.instantiate()
	add_child(fx)

func pray() -> void:
	$AnimationPlayer.play("cast1")
