class_name Page
extends Node3D


@onready var rune_sprite := $PageMesh/Rune

func set_rune(rune: Rune) -> void:
	rune_sprite.texture = rune.texture
