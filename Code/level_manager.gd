extends Node2D

var coins_collected = 0

func add_coins(amount):
	coins_collected += amount
	$CanvasLayer/LevelUI/VBoxContainer/CurrencyDisplayCoins/CoinsCollected.text = str(coins_collected)

func update_fuel_UI(value):
	$CanvasLayer/LevelUI/VBoxContainer/HBoxContainer/FuelBar.value = value
	if value <= 30:
		$CanvasLayer/LevelUI/VBoxContainer/HBoxContainer/AnimationPlayer.play("Alarm")
	else:
		$CanvasLayer/LevelUI/VBoxContainer/HBoxContainer/AnimationPlayer.play("Idle")

func update_score(value):
	$CanvasLayer/LevelUI/LabelDistance.text = str(value) + " m"
