class_name Course
extends Node2D

@export var player:Player
var marker: PackedScene = preload("res://scenes/Marker.tscn")

func _ready():
	var m: Sprite2D = marker.instantiate()
	m.scale = Vector2(.1,.1)
	m.global_position = player.global_position
	print("Player jump hieght: ", player.jump_height)
	m.position.y -= (player.jump_height - player.capsule_height)
	add_child(m)
