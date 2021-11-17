extends Node2D

var enemy_name = "ghost"
var health = 10
var attack = 2
var defense = 3
var speed = 1
var experience = 2

func reward_experience():
	Global.player_experience += experience
