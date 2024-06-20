extends Node
@export var next_level: PackedScene
@export var lvl_num: int

# Called when the node enters the scene tree for the first time.
func _ready():
	$WinScreen.hide()
	$Shader.material.set_shader_parameter("onoff",false)
	
	
func on_win():
	if Global.stage <= lvl_num:
		Global.stage = lvl_num+1
	$WinScreen.show()
	$Shader.material.set_shader_parameter("onoff",true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_next_level_pressed():
	get_tree().change_scene_to_packed(next_level)


func _on_menu_pressed():
	get_tree().change_scene_to_file("res://main.tscn")
