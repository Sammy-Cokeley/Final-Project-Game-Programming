extends Node2D

onready var player = $Player
onready var guiTextBox = $MarginContainer/TextBox

export(Resource) var enemy_list = enemy_list as EnemyList

var inTallGrass = false
var nextEnemy = ""

func _ready():
	player.position = Global.player_position
	determine_next_enemy()
	GameEvents.emit_next_enemy(nextEnemy)

func _on_Area2D_area_entered(_area):
	Global.player_position = player.position
	Global.player_position.x = 8
	Global.goto_scene("res://Start.tscn")

func _on_AreaToBoss_area_entered(_area):
	Global.player_position = player.position
	Global.player_position.x = 248
	Global.goto_scene("res://Boss.tscn")

func _on_BattleArea_area_entered(_area):
	GameEvents.emit_signal("in_tall_grass", true)
	print("entered battle area")


func _on_BattleArea_area_exited(area):
	GameEvents.emit_signal("out_of_tall_grass", false)
	print("left battle area")

func determine_next_enemy():
	var rand = int(rand_range(0,5))
	nextEnemy = enemy_list.enemy_list[rand]
	print(nextEnemy)
