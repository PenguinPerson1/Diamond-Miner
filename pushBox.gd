extends Area2D

var start_pos

# Called when the node enters the scene tree for the first time.
func _ready():
	start_pos = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func push(vector):
	$RayCast2D.target_position = vector
	$RayCast2D.force_raycast_update()
	if !$RayCast2D.is_colliding():
		var new_pos = position + vector
		var tween = get_tree().create_tween().bind_node(self)
		tween.tween_property(self, "position", new_pos, 0.1)
		return true
	else:
		return false
func pull(vector):
	var new_pos = position + vector
	var tween = get_tree().create_tween().bind_node(self)
	tween.tween_property(self, "position", new_pos, 0.1)
	return true
		
func undo():
	pass

func reset():
	position = start_pos
	
