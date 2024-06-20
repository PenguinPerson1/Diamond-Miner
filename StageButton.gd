extends Button

@export var id : int

# Called when the node enters the scene tree for the first time.
func _ready():
	text = "Stage %s" % id
	disabled = Global.stage < id
	pressed.connect($'../../..'.stage_pressed.bind(id))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
