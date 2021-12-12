extends Node

var player_position = Vector2(184,120)

var player_level
var player_max_health
var player_current_health
var player_defense
var player_attack
var player_speed

var enemy_name

var battle_potential = false

var current_scene = null

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	GameEvents.connect("in_tall_grass", self, "set_battle_potential")
	GameEvents.connect("out_of_tall_grass", self, "set_battle_potential")
	GameEvents.connect("next_enemy",self, "set_enemy_name")
	GameEvents.connect("update_stats", self, "update_stats")

func goto_scene(path):
	call_deferred("_deferred_goto_scene", path)

func _deferred_goto_scene(path):
	current_scene.free()	
	var s = ResourceLoader.load(path)
	current_scene = s.instance()
	get_tree().get_root().add_child(current_scene)

func _check_for_battle():
	if battle_potential:
		var randomNumber = rand_range(0,1)
		if randomNumber <= 0.2:
			yield(get_tree().create_timer(1.0), "timeout")
			Global.goto_scene("res://Battle.tscn")

func set_battle_potential(potential):
	battle_potential = potential

func set_enemy_name(next_enemy):
	enemy_name = next_enemy

func update_stats(stats):
	player_max_health = stats.max_health
	player_current_health
	player_defense = stats.defense
	player_attack = stats.attack
	player_speed = stats.speed
