extends Node2D

export var velocity = 5
var tile_size = 16
var inputs = {"Right": Vector2.RIGHT, "Left": Vector2.LEFT, "Up": Vector2.UP, "Down": Vector2.DOWN}

var level = 1
var health = 10
var defense = 5
var attack = 7
var speed = 5

onready var ray = $RayCast2D
onready var animationPlayer = $AnimationPlayer
onready var tween = $Tween

func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2

func _unhandled_input(event):
	if tween == null:
		return
	if tween.is_active():
		return
	for dir in inputs.keys():
		if Input.is_action_pressed(dir):
			move(dir)

func move(dir):
	ray.cast_to = inputs[dir] * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		animationPlayer.play("movement")
#		position += inputs[dir] * tile_size
		move_tween(inputs[dir])

func move_tween(dir):
	tween.interpolate_property(self, "position", position, position + dir * tile_size, 1.0/velocity, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
