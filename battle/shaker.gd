extends Node3D

@export var noise: Noise
@export var shake_intensity: float
@export var shake_frequency: float
@onready var cam := $Camera3D
var elapsed = 0.0;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	elapsed += delta
	if(shake_intensity > 0):
		var t = elapsed * shake_frequency
		cam.position.x = noise.get_noise_2d(t, 0.0) * shake_intensity
		cam.position.y = noise.get_noise_2d(0.0, t) * shake_intensity
