extends Node2D

var num_hills = 2
var slice = 10
var hill_range = 100

var screensize
var terrain = Array()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	screensize = get_viewport().get_visible_rect().size
	terrain = Array()
	var start_y = screensize.y * 3/4 + (-hill_range + randi() % hill_range * 2)
	terrain.append(Vector2(0, start_y))
	
	
func add_hills():
	var hill_width = screensize.x / num_hills
	var hill_slices = hill_width / slice
	var start = terrain[-1]
	for i in range(num_hills):
		var height = randi() % hill_range
		start.y -= height
		for j in range(0, hill_slices):
			var hill_point = Vector2()
			hill_point.x = start.x + j * slice + hill_width * i
			hill_point.y = start.y + height * cos(2 * PI / hill_slices * j)
			$Line2D.add_point(hill_point)
		start.y += height


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
