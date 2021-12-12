extends Node

signal dialog_initiated(dialogue)
signal dialog_finished
signal in_tall_grass(potential)
signal out_of_tall_grass(potential)
signal next_enemy(enemy)
signal update_stats(stats)
signal gui_stats(stats)

func emit_dialog_initiated(dialogue: Dialogue):
	print("emit dialog init")
	call_deferred("emit_signal", "dialog_initiated", dialogue)

func emit_dialog_finished():
	call_deferred("emit_signal", "dialog_finished")

func emit_in_tall_grass(potential):
	call_deferred("emit_signal", "in_tall_grass", potential)

func emit_out_of_tall_grass(potential):
	call_deferred("emit_signal", "out_of_tall_grass", potential)

func emit_next_enemy(enemy):
	call_deferred("emit_signal", "next_enemy", enemy)

func emit_update_stats(stats):
	#print("emit stats update")
	call_deferred("emit_signal", "update_stats", stats)

func emit_gui_stats(stats):
	call_deferred("emit_signal", "gui_stats", stats)
