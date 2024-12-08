extends RigidBody2D

var wheels = []
var speed = 60000
var max_speed = 50
var fuel = 100
var dead = false
var driving = 0
var brake_force = 1000000

var starting_position: Vector2
var current_distance: float = 0
var scale_factor: float = 50.0

func _ready():
	wheels = get_tree().get_nodes_in_group("wheel")
	get_tree().get_current_scene().get_node("Player").refuel()
	starting_position = global_position
	

func _physics_process(delta):
	driving = 0
	
	if fuel > 0 && !dead:
		if Input.is_action_pressed("ui_right"):
			driving += 1
			apply_torque_impulse(-6000 * delta * 60)
			for wheel in wheels:
				if wheel.angular_velocity < max_speed:
					wheel.apply_torque_impulse(speed * delta * 40)
				
		if Input.is_action_pressed("ui_left"):
			driving += 1
			apply_torque_impulse(2000 * delta * 60)
			for wheel in wheels:
				if wheel.angular_velocity >  -max_speed:
					wheel.apply_torque_impulse(-speed * delta * 40)
	else:
		if $GameOverTimer.is_stopped():
			$GameOverTimer.start()
	
	if Input.is_action_pressed("ui_down"):
		# Apply brake effect
		for wheel in wheels:
			if wheel.angular_velocity > 0:
				wheel.apply_torque_impulse(-brake_force * delta) # Slow down forward motion
			elif wheel.angular_velocity < 0:
				wheel.apply_torque_impulse(brake_force * delta) # Slow down reverse motion
			
	if $Car.global_rotation_degrees > 95 || $Car.global_rotation_degrees < -95 && !dead:
		dead = true
		$Head/Pinjoint2DHead.node_b = ""
		
	if driving == 1:
		$EngineSFX.pitch_scale = lerp($EngineSFX.pitch_scale, 2.0, 2 * delta)
		use_fuel(delta)
	else:
		$EngineSFX.pitch_scale = lerp($EngineSFX.pitch_scale, 1.0, 2 * delta)
	update_distance()
	get_parent().update_score(int(current_distance))

func refuel():
	fuel = 100
	get_parent().update_fuel_UI(fuel)

func update_distance():
	# Calculate distance in meters
	var pixel_distance = starting_position.distance_to(global_position)
	current_distance = pixel_distance / scale_factor

func finish_game():

	# Disable player controls
	dead = true
	const main_menu = "res://Scenes/main_menu.tscn"
	get_tree().change_scene_to_file(main_menu)

func use_fuel(delta):
	fuel -= 10 * delta
	fuel = clamp(fuel, 0, 100)
	get_parent().update_fuel_UI(fuel)

func _on_game_over_timer_timeout() -> void:
	get_tree().reload_current_scene()
