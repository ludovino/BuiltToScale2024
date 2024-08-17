class_name Minigame
extends Node3D

@export var battle_ui_disabled : bool

signal succeeded
signal failed

#override these functions

#func _ready() -> void:
#	variable initialization goes here

#func _enter_tree() -> void:
#	start / restart the minigame
#	make the camera active, start the clock, etc etc
	
#func _exit_tree() -> void:
#	end the minigame
#	deactivate the camera
