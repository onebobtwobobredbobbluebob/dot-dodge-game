extends LineEdit

var submitted: bool = false
var submitted_string: String = ""

func _ready() -> void:
	connect("text_submitted", submit_text)

func submit_text(string: String):
	submitted_string = string
	submitted = true
	release_focus()
