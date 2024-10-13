extends Node

@onready var scoreLabel: Label = $Score

var score = 0

func add_point():
	score += 1
	scoreLabel.text = "You collected " + str(score) + " coins."
	print(score)
