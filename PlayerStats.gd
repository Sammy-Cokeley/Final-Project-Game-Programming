extends Resource


class_name PlayerStats

signal health_changed(new_health, old_health)
signal health_depleted


var health 
export var max_health = 1 setget set_max_health, _get_max_health
export var attack = 1 setget, _get_attack
export var defense = 1 setget, _get_defense
export var speed = 1 setget, _get_speed
var is_alive: bool setget, _is_alive
var level: int

func reset():
	health = self.max_health

func copy():
	var copy = duplicate()
	copy.health = health
	return copy

func take_damage(damage):
	var previous_health = health
	health -= damage
	health = max(0,health)
	emit_signal("health_changed", health, previous_health)
	if health == 0:
		emit_signal("health_depleted")

func set_max_health(value: int):
	if value == null:
		return
	max_health = max(1, value)

func _is_alive() -> bool:
	return health >= 0

func _get_max_health() -> int:
	return max_health

func _get_attack() -> int:
	return attack

func _get_defense() -> int:
	return defense

func _get_speed() -> int:
	return speed

func _get_level() -> int:
	return level
