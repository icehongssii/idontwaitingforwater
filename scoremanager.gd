extends Node

var high_scores = []
var max_scores = 10
var file_path = "user://high_scores.save"

func _ready():
	load_high_scores()

func add_score(nickname, score):
	high_scores.append({"name": nickname, "score": score})
	high_scores.sort_custom(self, "sort_scores")
	if high_scores.size() > max_scores:
		high_scores.resize(max_scores)
	save_high_scores()

func get_high_scores():
	return high_scores

func save_high_scores():
	var file = File.new()
	file.open(file_path, File.WRITE)
	file.store_var(high_scores)
	file.close()

func load_high_scores():
	var file = File.new()
	if file.file_exists(file_path):
		file.open(file_path, File.READ)
		high_scores = file.get_var()
		file.close()
	else:
		high_scores = []

static func sort_scores(a, b):
	return a["score"] > b["score"]
