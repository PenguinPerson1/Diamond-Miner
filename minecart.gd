extends Area2D
@export var is_full = true
@export var is_start_right = true

var start_pos

# Called when the node enters the scene tree for the first time.
func _ready():
	start_pos = position
	if is_full:
		if is_start_right:
			$AnimatedSprite2D.animation = 'right_full'
		else:
			$AnimatedSprite2D.animation = 'up_full'
	else:
		if is_start_right:
			$AnimatedSprite2D.animation = 'right_empty'
		else:
			$AnimatedSprite2D.animation = 'up_empty'


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func push(vector):
	$RayCast2D.target_position = vector
	$RayCast2D2.target_position = vector
	$RayCast2D.force_raycast_update()
	$RayCast2D2.force_raycast_update()
	if !$RayCast2D.is_colliding() && $RayCast2D2.is_colliding():
		var new_pos = position + vector
		var tween = get_tree().create_tween().bind_node(self)
		tween.tween_property(self, "position", new_pos, 0.1)
		if vector.x != 0:
			$AnimatedSprite2D.animation = 'right_full'
		else: 
			$AnimatedSprite2D.animation = 'up_full'
		return true
	return false
		
func pull(vector):
	$RayCast2D3.target_position = vector / 2
	$RayCast2D2.target_position = vector / 2
	$RayCast2D3.force_raycast_update()
	$RayCast2D2.force_raycast_update()
	if !$RayCast2D3.is_colliding() && $RayCast2D2.is_colliding():
		var new_pos = position + vector
		var tween = get_tree().create_tween().bind_node(self)
		tween.tween_property(self, "position", new_pos, 0.1)
		if vector.x != 0:
			$AnimatedSprite2D.animation = 'right_full'
		else: 
			$AnimatedSprite2D.animation = 'up_full'
		return true
	return false

func undo():
	pass

func reset():
	position = start_pos
	if is_full:
		if is_start_right:
			$AnimatedSprite2D.animation = 'right_full'
		else:
			$AnimatedSprite2D.animation = 'up_full'
	else:
		if is_start_right:
			$AnimatedSprite2D.animation = 'right_empty'
		else:
			$AnimatedSprite2D.animation = 'up_empty'
