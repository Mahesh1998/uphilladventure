extends Control

var PauseModalScene: PackedScene = preload("res://modal/pause_modal.tscn")
var texture_off: Texture = preload("res://Images/Other/pedal_off.png")
var texture_on: Texture = preload("res://Images/Other/pedal_on.png")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func pause_game() -> void:
	var modal: PauseModal = PauseModalScene.instantiate() as PauseModal
	add_child(modal)
	

func _on_button_pause_pressed() -> void:
	pause_game()
