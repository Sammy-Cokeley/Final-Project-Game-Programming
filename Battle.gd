extends Node2D

onready var enemySprite = $Enemy/EnemySprite
onready var GUI = $Control


export(Resource) var _runtime_data = _runtime_data as RuntimeData
export(Resource) var current_enemy

func _ready():
	current_enemy = load(determine_enemy())
	enemySprite.texture = current_enemy.sprite

func determine_enemy():
	var enemy_name = Global.enemy_name
	if enemy_name == "Slime":
		return "res://Enemies/Slime.tres"
	elif enemy_name == "Rat":
		return "res://Enemies/Rat.tres"
	elif enemy_name == "Lizard":
		return "res://Enemies/Lizard.tres"
	elif enemy_name == "Scorpion":
		return "res://Enemies/Scorpion.tres"
	elif enemy_name == "Snake":
		return "res://Enemies/Snake.tres"
	elif enemy_name == "Wolf":
		return "res://Enemies/Wolf.tres"
	elif enemy_name == "Cocatrice":
		return "res://Enemies/Cocatrice.tres"
	elif enemy_name == "Goblin":
		return "res://Enemies/Goblin.tres"
	elif enemy_name == "Ghost":
		return "res://Enemies/Ghost.tres"
