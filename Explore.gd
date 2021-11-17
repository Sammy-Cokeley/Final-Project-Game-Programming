extends Node2D

onready var player = $Player
onready var healthLabel = $MarginContainer/Label

func _ready():	
	player.health = Global.player_health
	player.position = Global.player_position
	healthLabel.text = "HP: " + str(player.health)

func _on_Area2D_area_entered(area):
	Global.player_position = player.position
	Global.player_position.x = 8
	Global.player_health = player.health
	Global.goto_scene("res://Start.tscn")

func _on_AreaToBoss_area_entered(area):
	Global.player_position = player.position
	Global.player_position.x = 248
	Global.player_health = player.health
	Global.goto_scene("res://Boss.tscn")

func _input(event):
	if Input.is_action_pressed("Change_Scene"):
		player.health -= 1
		healthLabel.text = "HP: " + str(player.health)
	if Input.is_action_pressed("Enter_battle"):
		Global.goto_scene("res://Battle.tscn")
