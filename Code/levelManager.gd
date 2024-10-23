extends Node2D

var coins_collected = 0

func add_coins(amount):
	coins_collected += amount
	$UI/Coin/Label.text = str(coins_collected)

func update_fuel_UI(value):
	$UI/Fuel/ProgressBar.value = value
	var stylebox = $UI/Fuel/ProgressBar.get("theme_override_styles/background")
	stylebox.bg_color = Color("#333333")      
