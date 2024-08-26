extends Camera3D

var originalRotation : Vector3
var initialised : bool

@export var joystickSensitivity : float
@export var horizontalBounds : float
@export var verticalBounds : float


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	originalRotation = rotation;
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var velocity = event.screen_relative
		rotate_y(deg_to_rad(-velocity.x * joystickSensitivity))
		rotation.y = clamp(rotation.y, originalRotation.y - deg_to_rad(verticalBounds), originalRotation.y + deg_to_rad(verticalBounds))
		
		rotate_x(deg_to_rad(-velocity.y * joystickSensitivity))
		rotation.x = clamp(rotation.x, originalRotation.x - deg_to_rad(horizontalBounds), originalRotation.x + deg_to_rad(horizontalBounds))
		
		rotation.z = deg_to_rad(0);
