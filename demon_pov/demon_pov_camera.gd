extends Camera3D

var originalRotation : Vector3
var initialised : bool

@export var joystickSensitivity : float
@export var horizontalBounds : float
@export var verticalBounds : float


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	originalRotation = rotation;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_updateInput(delta)
	
func _updateInput(delta : float) -> void:
	var velocity = Input.get_vector("minigame_left", "minigame_right", "minigame_up", "minigame_down")
	rotate_y(deg_to_rad(-velocity.x * joystickSensitivity))
	rotation.y = clamp(rotation.y, originalRotation.y - deg_to_rad(verticalBounds), originalRotation.y + deg_to_rad(verticalBounds))
	
	rotate_x(deg_to_rad(-velocity.y * joystickSensitivity))
	rotation.x = clamp(rotation.x, originalRotation.x - deg_to_rad(horizontalBounds), originalRotation.x + deg_to_rad(horizontalBounds))
	
	rotation.z = deg_to_rad(0);
		#rotation.x = clamp(rotation.x, deg_to_rad(-89), deg_to_rad(89))
