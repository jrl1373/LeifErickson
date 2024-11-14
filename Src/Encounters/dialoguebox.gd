extends Panel
var text1 = "a;sldkfjas;"
var text2 = "dssfasdf"
var wholetext = ""
var progress = 0 

func newtext(text):
	$Label.text = ""
	progress = 0
	wholetext= text

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = text1 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if progress < len(wholetext):
		progress += 1
		$Label.text = wholetext.substr(0,progress)


func _on_button_pressed():
	
	newtext("l;sakdjfl;sakdjf")
	pass # Replace with function body.
