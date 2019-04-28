extends Node2D

export var DucksLifeInSeconds = 0.75
export var KillDuckAtLifePoints = 0.2

export var Colors = {
	'blue':Color("#2b80b9"),
	'red':Color("#e74b3c"),
	'yellow':Color("#f2c311"),
	'cyan':Color("#1cbb9b"),
	'orange':Color("#ED8727"),
	'purple':Color("#89667B"),
	'green':Color("#87BF56"),
	'default': Color('#9e9e9e')	
}

var ColorCombinations = [
	['blue', 'red', 'purple'],
	['red', 'yellow', 'orange'],
	['yellow', 'cyan', 'green']
]

export var SelectableColors = [
	'red', 'blue', 'yellow', 'cyan'
]

func get_combined_color(a, b):
	for c in ColorCombinations:
		if c[0] == a && c[1] == b || c[1] == a && c[0] == b:
			return c[2]
			
	return 'default'

func get_color_by_name(key = ''):
	return Colors.get(key, Globals.Colors['default'])
	
