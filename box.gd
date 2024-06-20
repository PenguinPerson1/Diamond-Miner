extends Area2D

signal win

@export var is_pull = false
var reversed = false

var start_is_pull
var start_pos

# Called when the node enters the scene tree for the first time.
func _ready():
	start_is_pull = is_pull
	start_pos = position
	transform(is_pull)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func push(vector):
	reversed = false
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
	
	
func transform(to_is_pull=true):
	is_pull = to_is_pull
	if to_is_pull:
		add_to_group("pullable")
		$AnimatedSprite2D.animation = "pull"
	else:
		remove_from_group("pullable")
		$AnimatedSprite2D.animation = "push"
		
func undo():
	reversed = true
	
func _on_area_entered(area):
	if !reversed:
		if area.is_in_group("converters"):
			transform()
		if area.is_in_group("goals") && is_in_group("pullable"):
			win.emit()


func _on_area_exited(area):
	if reversed:
		if area.is_in_group("converters"):
			transform()
			
func reset():
	transform(start_is_pull)
	position = start_pos
