class_name LevelButton
extends TextureButton

@export var level_data: LevelData

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture_normal = level_data.thumbnail
	$LabelTitle.text = level_data.title


func _on_pressed() -> void:
	get_tree().change_scene_to_file(level_data.scene_path)


func _on_label_high_score_ready() -> void:
	pass # Replace with function body.
