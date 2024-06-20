extends Area2D

var tile_size = 64
var inputs = {
	"left": Vector2.LEFT,
	"right": Vector2.RIGHT,
	"up": Vector2.UP,
	"down": Vector2.DOWN
}
var history = []
var action = {}
var moving = false

# Called when the node enters the scene tree for the first time.
func _ready():
	position = $'../PlayerStart'.position
	

func _unhandled_input(event):
	if event.is_action_pressed("undo"):
		undo()
	elif event.is_action_pressed("reset"):
		get_tree().call_group("resetting","reset")
	else:
		for dir in inputs.keys():
			if event.is_action_pressed(dir):
				check_move(dir, Input.is_key_pressed(KEY_SHIFT))
func check_move(dir, is_pull):
	if !moving:
		$AnimatedSprite2D.animation = dir
		$RayCast2D.target_position = inputs[dir] * tile_size
		$RayCast2D.force_raycast_update()
		var collider = $RayCast2D.get_collider()
		if collider == null:
			move(dir, is_pull, collider)
			history.push_front(action)
			action = {}
			#just move
			
		elif collider.is_in_group("pushable") && collider.push(inputs[dir] * tile_size):
			move(dir, is_pull, collider)
			action["push"] = collider
			history.push_front(action)
			action = {}
			#move and push

func move(dir, is_pull, _collider):
	action = {
			"dir": inputs[dir]
		}
	if is_pull:
		$RayCast2D.target_position = inputs[dir] * tile_size * -1
		$RayCast2D.force_raycast_update()
		var coll_pull = $RayCast2D.get_collider()
		if coll_pull && coll_pull.is_in_group("pullable") && coll_pull.pull(inputs[dir] * tile_size):
			action["pull"] = coll_pull
	var new_pos = position + inputs[dir] * tile_size
	var tween = get_tree().create_tween().bind_node(self)
	tween.tween_property(self, "position", new_pos, 0.1)
	moving = true
	await tween.finished
	moving = false
		
		
func undo():
	action = history.pop_front()
	if action:
		position+=action["dir"] * tile_size * -1
		if action.get("push"):
			action["push"].undo()
			action["push"].position+=action["dir"] * tile_size * -1
		if action.get("pull"):
			action["pull"].undo()
			action["pull"].position+=action["dir"] * tile_size * -1
			
func reset():
	position = $'../PlayerStart'.position
	action = {}
	history.clear()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
