extends Node

signal _on_next_day
signal _on_next_month
signal _on_next_year


var money: int = 1000

var water: int = 100
var citizens: int = 0

var day: int = 12
var month: int = 3
var year: int = 4038

func next_day():
	_on_next_day.emit()

func next_month():
	_on_next_month.emit()

func next_year():
	_on_next_year.emit()
