extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	$StageSelect.hide()
	$MainMenu.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func stage_pressed(stage):
	var format_string = "res://stage%s.tscn"
	get_tree().change_scene_to_file(format_string % stage)
	
func show_stages():
	$MainMenu.hide()
	$StageSelect.show()


func _on_quit_pressed():
	get_tree().quit()


func _on_back_pressed():
	$MainMenu.show()
	$StageSelect.hide()
