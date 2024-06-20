extends CanvasLayer
signal menu
signal next_level


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_menu_pressed():
	menu.emit()

func _on_next_level_pressed():
	next_level.emit()
