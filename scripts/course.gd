class_name Course
extends Node2D

@export var player:Player
@export var ground: Ground


var marker: PackedScene = preload("res://scenes/Marker.tscn")
var marker_2: PackedScene = preload("res://scenes/Marker2.tscn")

var timer: Timer = Timer.new()

var obstacle: PackedScene = preload("res://scenes/Obstacle.tscn")
var spawn_distance: float = 200.0
var spawn_time: float = 1.0
var prev: Obstacle # The most recent obstacle

func _ready():

	timer.timeout.connect(on_timer_timeout)
	add_child(timer)
	timer.start(.5)

	# var m: Sprite2D = marker.instantiate()
	# m.scale = Vector2(.1,.1)
	# m.global_position = player.global_position
	# print("Player jump hieght: ", player.jump_height)
	# m.position.y -= (player.jump_height - player.capsule_height * 2)
	# add_child(m)

	# var m2: Sprite2D = marker.instantiate()
	# m2.scale = Vector2(.1,.1)
	# m2.global_position = player.global_position
	# print("Player jump hieght: ", player.jump_height)
	# m2.position.y -= (player.jump_height - player.capsule_height)
	# add_child(m2)

func on_timer_timeout():
	spawn_obstacle()
	timer.start(spawn_time)

func spawn_obstacle():
	var spawn_y: float = calc_spawn_y()
	var new_obstacle: Obstacle = obstacle.instantiate()
	new_obstacle.global_position.x = player.global_position.x + spawn_distance
	new_obstacle.global_position.y = spawn_y
	add_child(new_obstacle)
	prev = new_obstacle

func calc_spawn_y() -> float:
	var shape: RectangleShape2D
	var highest_top: float
	var jump_apex: float
	shape = ground.collider.shape
	var ground_top: float = ground.collider.global_transform.origin.y - (shape.size.y * ground.collider.global_transform.get_scale().y) / 2

	if prev:
		shape = prev.collider.shape
		highest_top = prev.collider.global_transform.origin.y - (shape.size.y * prev.collider.global_transform.get_scale().y) / 2
	else:
		shape = ground.collider.shape
		highest_top = ground.collider.global_transform.origin.y - (shape.size.y * ground.collider.global_transform.get_scale().y) / 2

	jump_apex = highest_top - player.jump_max_height
	var upper_bound:float = jump_apex
	var lower_bound:float  = ground_top

	create_marker_2(Vector2(player.global_position.x,lower_bound))
	create_marker(Vector2(player.global_position.x,upper_bound))

	var r = randf_range(lower_bound, upper_bound)
	return r

func create_marker(pos):
	var m: Sprite2D = marker.instantiate()
	m.scale = Vector2(.1,.1)
	m.global_position = pos
	# print("Player jump hieght: ", player.jump_height)
	# m.position.y -= (player.jump_height - player.capsule_height * 2)
	add_child(m)

func create_marker_2(pos):
	var m: Sprite2D = marker_2.instantiate()
	m.scale = Vector2(.1,.1)
	m.global_position = pos
	# print("Player jump hieght: ", player.jump_height)
	# m.position.y -= (player.jump_height - player.capsule_height * 2)
	add_child(m)
