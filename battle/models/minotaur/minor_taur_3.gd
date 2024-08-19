extends Node3D

func climb():
	visible = true
	$AnimationPlayer.play("ClimbFromHell")
	$AnimationPlayer.queue("Idle")

func idle():
	$AnimationPlayer.play("Idle")
