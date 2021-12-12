extends Node2D

onready var player = $Player
onready var guiTextBox = $MarginContainer/TextBox

func _ready():
	player.position = Global.player_position
	guiTextBox.visible = false

func _on_AreaToExplore_area_entered(area):
	Global.player_position = player.position
	Global.player_position.x = 8
	Global.goto_scene("res://Explore.tscn")

func _input(event):
	pass
