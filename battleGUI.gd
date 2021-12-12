extends Control

onready var _player_health = $PlayerHealth/RichTextLabel
onready var playerSelection = $ActionSelection
onready var attack_button = $ActionSelection/PlayerActions/Attack
onready var defend_button = $ActionSelection/PlayerActions/Defend
onready var flee_button = $ActionSelection/PlayerActions/Flee
onready var playerHealth = $PlayerHealth
onready var dialogBox = $TextBox
onready var dialogText = $TextBox/DialogueLabel


export(Resource) var current_enemy
export(Resource) var _runtime_data = _runtime_data as Resource

func _ready():
	playerHealth.visible = true
	dialogBox.visible = true
	current_enemy = load("res://Enemies/"+str(Global.enemy_name)+".tres")
	dialogText.text = "You encountered a " + current_enemy.enemy_name + "!"
	if current_enemy.speed >= Global.player_speed:
		_runtime_data.current_gameplay_state = Enums.GameplayState.ENEMY_TURN
	else:
		_runtime_data.current_gameplay_state = Enums.GameplayState.PLAYER_TURN

func _input(event):
	if Input.is_action_pressed("Interact"):
		if _runtime_data.current_gameplay_state == Enums.GameplayState.ENEMY_TURN:
			enemy_turn()
		elif _runtime_data.current_gameplay_state == Enums.GameplayState.PLAYER_TURN:
			player_turn()

func player_turn():
	_change_display(true)
	attack_button.grab_focus()
	#_runtime_data.current_gameplay_state = Enums.GameplayState.ENEMY_TURN

func enemy_turn():
	_change_display(false)
	if current_enemy.turn() == "attack":
		pass
	dialogText.text = current_enemy.enemy_name + " attacked player!"
	_stats_update()
	#_runtime_data.current_gameplay_state = Enums.GameplayState.PLAYER_TURN

func _stats_update():
	_player_health.text = "Player\nHP-" + str(Global.player_current_health)

func _on_Attack_focus_entered():
	attack_button.text =">Attack"

func _on_Attack_focus_exited():
	attack_button.text =" Attack"

func _on_Defend_focus_entered():
	defend_button.text =">Defend"

func _on_Defend_focus_exited():
	defend_button.text =" Defend"

func _on_Flee_focus_entered():
	flee_button.text =">Flee"

func _on_Flee_focus_exited():
	flee_button.text =" Flee"

func _change_display(state):
	playerSelection.visible = state
