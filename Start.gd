extends Node2D

onready var player = $YSort/Player
onready var guiTextBox = $MarginContainer/TextBox
onready var nextEnemy 

export(Resource) var _tutorial_sign = _tutorial_sign as Dialogue 
export(Resource) var _wizard_dialogue = _wizard_dialogue as Dialogue
export(Resource) var _runtime_data = _runtime_data as RuntimeData
export(Resource) var enemy_list = enemy_list as EnemyList

var inFrontOfSign = false
var inFrontOfWizard = false

func _ready():
	player.position = Global.player_position
	GameEvents.emit_next_enemy(nextEnemy)
	determine_next_enemy()
	GameEvents.emit_next_enemy(nextEnemy)

func _on_EnterNextArea_area_entered(_area):
	Global.player_position = player.position
	Global.player_position.x = 248
	Global.goto_scene("res://Explore.tscn")

func _input(_event):
	if Input.is_action_pressed("Interact") and _runtime_data.current_gameplay_state == Enums.GameplayState.FREEWALK:
		if inFrontOfSign:
			GameEvents.emit_dialog_initiated(_tutorial_sign)
			print("testing sign")
		elif inFrontOfWizard:
			GameEvents.emit_dialog_initiated(_wizard_dialogue)
			print("testing wizard")
	#elif Input.is_action_pressed("Enter_battle"):
	#	Global.goto_scene("res://Battle.tscn")

func determine_next_enemy():
	var rand = int(rand_range(0,0))
	nextEnemy = enemy_list.enemy_list[rand]


func _on_TestDialogue_area_entered(area):
	inFrontOfSign = true


func _on_TestDialogue_area_exited(area):
	inFrontOfSign = false


func _on_WizardDialogue_area_entered(area):
	inFrontOfWizard = true

func _on_WizardDialogue_area_exited(area):
	inFrontOfWizard = false

func _on_battle_area_entered(area):
	GameEvents.emit_signal("in_tall_grass", true)

func _on_battle_area_exited(area):
	GameEvents.emit_signal("out_of_tall_grass", false)
