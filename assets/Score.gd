extends CanvasLayer

var score = 0

func increment_score():
	score += 1
	$MarginContainer/Label.text = "Score : %d" % [score]
