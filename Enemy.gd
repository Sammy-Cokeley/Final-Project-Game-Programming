extends Resource

class_name Enemy

export (String) var enemy_name
export (int) var health
export (int) var attack
export (int) var defense
export (int) var speed
export (int) var experience
export (Texture) var sprite
export (String) var opening_dialog 

func turn():
	return "attack"
