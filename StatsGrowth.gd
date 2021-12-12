extends Resource
class_name StatsGrowth

export var max_health_curve: Curve
export var attack_curve: Curve
export var defense_curve: Curve
export var speed_curve: Curve


func create_stats(level: int) -> PlayerStats:
	var stats := PlayerStats.new()
	stats.max_health = _get_max_health(level)
	stats.attack = _get_attack(level)
	stats.defense = _get_defense(level)
	stats.speed = _get_speed(level)
	stats.reset() 
	return stats

func _get_interpolated_level(value: int) -> float:
	#print("interpolated level "+str(float(value) / float(20)))
	return float(value) / float(20)

func _get_max_health(level) -> int:
	assert(max_health_curve != null)
	var value: float = _get_interpolated_level(level)
	print("max health " + str(max_health_curve.interpolate_baked(value)))
	return int(max_health_curve.interpolate_baked(value))

func _get_attack(level) -> int:
	assert(attack_curve != null)
	var value: float = _get_interpolated_level(level)
	return int(attack_curve.interpolate_baked(value))

func _get_defense(level) -> int:
	assert(defense_curve != null)
	var value: float = _get_interpolated_level(level)
	return int(defense_curve.interpolate_baked(value))

func _get_speed(level) -> int:
	assert(speed_curve != null)
	var value: float = _get_interpolated_level(level)
	return int(speed_curve.interpolate_baked(value))
