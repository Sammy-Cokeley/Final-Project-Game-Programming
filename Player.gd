extends Node2D

class_name Player

export(Resource) var _runtime_data = _runtime_data as RuntimeData
export var level_growth: Resource

export var max_health = 10
export var current_health = 10
export var attack = 8
export var defense = 5
export var speed = 5
export var level = 1

var experience = 0
var experience_required = get_required_experience(level + 1)
var stats: Resource

export var velocity = 5
var tile_size = 16
var inputs = {"Right": Vector2.RIGHT, "Left": Vector2.LEFT, "Up": Vector2.UP, "Down": Vector2.DOWN}

onready var ray = $RayCast2D
onready var animationPlayer = $AnimationPlayer
onready var tween = $Tween

func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2
	stats = level_growth.create_stats(level)
	GameEvents.emit_update_stats(stats)
	GameEvents.emit_gui_stats("Level-" + str(level) + "\nHealth-" + str(current_health) + "/" + str(max_health) + "\nAttack-" + str(attack) + "\nDefense-" + str(defense) + "\nSpeed-" + str(speed))


func get_required_experience(level):
	return round(pow(level, 1.9) + level * 4)

func gain_experience(amount):
	experience += amount
	var growth_data = []
	while experience >= experience_required:
		experience -= experience_required
		level_up()

func level_up():
	level += 1
	experience_required = get_required_experience(level+1)
	stats = level_growth.create_stats(level)
	var new_stats = level_growth.create_stats(level)
	max_health = new_stats.max_health
	attack = new_stats.attack
	defense = new_stats.defense
	speed = new_stats.speed
	GameEvents.emit_update_stats(stats)
	GameEvents.emit_gui_stats("Level-" + str(level) + "\nHealth-" + str(current_health) + "/" + str(max_health) + "\nAttack-" + str(attack) + "\nDefense-" + str(defense) + "\nSpeed-" + str(speed))

func _unhandled_input(_event):
	if tween == null:
		return
	if tween.is_active():
		return
	for dir in inputs.keys():
		if Input.is_action_pressed(dir):
			if _runtime_data.current_gameplay_state == Enums.GameplayState.FREEWALK:
				move(dir)
	if Input.is_action_pressed("Enter_battle"):
		print("Exp gained")
		gain_experience(10)


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
	Global._check_for_battle()


