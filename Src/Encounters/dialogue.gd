extends Node2D
var label = null
var text1 = "a;sldkfjas;"
var text2 = "dssfasdf"
var dialoguelist = [text1, text2]
var dialoguecounter = 0
var wholetext = ""
var progress = 0 

func newtext(text):
	label.text = ""
	progress = 0
	wholetext= text
	
func newlist(list):
	dialoguecounter = 0
	dialoguelist = list 
	newtext(dialoguelist[dialoguecounter])

# Called when the node enters the scene tree for the first time.
func _ready():
	label = $Control/Panel/Label
	newtext(dialoguelist[0]) 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if progress < len(wholetext):
		progress += 1
		label.text = wholetext.substr(0,progress)


func _on_button_pressed():
	if dialoguecounter < len(dialoguelist)-1:
		dialoguecounter += 1
	newtext(dialoguelist[dialoguecounter])
	pass # Replace with function body.
