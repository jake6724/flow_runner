class_name Player
extends CharacterBody2D

# Store player information and child references that will be used across many states

@onready var ap: AnimationPlayer = $AnimationPlayer
@onready var collider: CollisionShape2D = $CollisionShape2D
@onready var sprite: Sprite2D = $Sprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var speed = 0
var jump_power: float = 350
var jump_count: int = 0
var jump_max:int = 2
var jump_in_progress: bool = false

var jump_height = (jump_power ** 2) / (2 * gravity)
var capsule_height: float


signal player_ready

func _ready():
	player_ready.emit()	
	capsule_height = collider.get_shape().height

func _process(_delta):

	if not is_on_floor():
		velocity.y += gravity * _delta

	velocity.x = speed

	move_and_slide()
