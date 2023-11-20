extends Node2D


var Coin = preload("res://coins.tscn")



func _on_timer_timeout():
	var coinTemp = Coin.instantiate()
	var rng = RandomNumberGenerator.new()
	var randint = rng.randi_range(100, 2000)
	coinTemp.position = Vector2(450, randint)
	add_child(coinTemp)
