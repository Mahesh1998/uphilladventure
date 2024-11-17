extends RigidBody2D

var wheels = []
var speed = 60000
var max_speed = 50
var fuel = 100
var dead = false
var driving = 0

func _ready():
	wheels = get_tree().get_nodes_in_group("wheel")
	#get_parent().update_fuel_UI(fuel)


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
			
	if $Head.rotation_degrees > 90 || $Head.rotation_degrees < -90 && !dead:
		dead = true
		$Head/Pinjoint2DHead.node_b = ""
		
	if driving == 1:
		$EngineSFX.pitch_scale = lerp($EngineSFX.pitch_scale, 2.0, 2 * delta)
		use_fuel(delta)
	else:
		$EngineSFX.pitch_scale = lerp($EngineSFX.pitch_scale, 1.0, 2 * delta)


func refuel():
	fuel = 100
	get_parent().update_fuel_UI(fuel)


func use_fuel(delta):
	fuel -= 10 * delta
	fuel = clamp(fuel, 0, 100)
	get_parent().update_fuel_UI(fuel)

func _on_game_over_timer_timeout() -> void:
	get_tree().reload_current_scene()
