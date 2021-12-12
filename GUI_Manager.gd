extends Control

export(NodePath) onready var _dialog_text = get_node(_dialog_text) as RichTextLabel
export(Resource) var _current_dialogue = _current_dialogue as Dialogue
export(Resource) var _runtime_data = _runtime_data as RuntimeData

onready var dialogue_box = $TextBox
onready var menu_box = $Menu
onready var stats_button = $Menu/VBoxContainer/Stats
onready var quit_button = $Menu/VBoxContainer/Quit
onready var _stats_display = $Stats
onready var _stats_label = $Stats/StatsLabel
onready var _player_health = $PlayerHealth/RichTextLabel

var _current_slide_index := 0
var stat_selected = false
var quit_selected = false

func _ready():
	GameEvents.connect("dialog_initiated", self, "_on_dialog_intitiated")
	GameEvents.connect("dialog_finished",self,"_on_dialog_finished")
	GameEvents.connect("gui_stats", self, "_stats_update")

func _input(_event):
	if Input.is_action_just_pressed("Interact"):
		if _runtime_data.current_gameplay_state == Enums.GameplayState.IN_DIALOG:
			if _current_slide_index < _current_dialogue.dialog_slides.size() - 1:
				_current_slide_index += 1
				show_slide()
			elif _runtime_data.current_gameplay_state == Enums.GameplayState.IN_DIALOG:
				GameEvents.emit_dialog_finished()
		elif _runtime_data.current_gameplay_state == Enums.GameplayState.IN_MENU:
			if stat_selected:
				_on_Test_pressed()
				_on_Button_focus_exited()
				_stats_display.visible = true
				stats_button.release_focus()
				_runtime_data.current_gameplay_state = Enums.GameplayState.VIEWING_STATS
			elif quit_selected:
				pass
	elif Input.is_action_just_pressed("Menu"):
		_runtime_data.current_gameplay_state = Enums.GameplayState.IN_MENU
		stats_button.grab_focus()
		menu_box.visible = true
	elif Input.is_action_just_pressed("Back"):
		if _runtime_data.current_gameplay_state == Enums.GameplayState.IN_MENU:
			_runtime_data.current_gameplay_state = Enums.GameplayState.FREEWALK
			menu_box.visible = false
		elif _runtime_data.current_gameplay_state == Enums.GameplayState.VIEWING_STATS:
			_stats_display.visible = false
			stats_button.grab_focus()
			_runtime_data.current_gameplay_state = Enums.GameplayState.IN_MENU
	elif Input.is_action_pressed("Enter_battle"):
		pass
		#Player.gain_experience(10)
		#print("experience gained")
		#print(str(Player.level))

func show_slide() -> void:
	_dialog_text.text = _current_dialogue.dialog_slides[_current_slide_index]


func _on_dialog_intitiated(dialogue: Dialogue) -> void:
	print(dialogue.dialog_slides[0])
	_runtime_data.current_gameplay_state = Enums.GameplayState.IN_DIALOG
	_current_dialogue = dialogue
	_current_slide_index = 0
	dialogue_box.visible = true
	show_slide()
	pass

func _on_dialog_finished() -> void:
	dialogue_box.visible = false
	_runtime_data.current_gameplay_state = Enums.GameplayState.FREEWALK

func _stats_update(stats):
	print("updating stats")
	_stats_label.text = stats
	#_player_health.text = "Player\nHP-" + str(Global.player_current_health)

func _on_Button_focus_entered():
	stat_selected = true
	stats_button.text = ">Stats"

func _on_Button_focus_exited():
	stat_selected = false
	stats_button.text = " Stats"


func _on_Button2_focus_entered():
	quit_selected = true
	quit_button.text = ">Quit"


func _on_Button2_focus_exited():
	quit_selected = false
	quit_button.text = " Quit"


func _on_Test_pressed():
	print("here are the stats")
