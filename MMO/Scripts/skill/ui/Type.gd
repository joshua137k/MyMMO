extends VBoxContainer

@export var SkillEditor:Control


func reload(type:String)->void:
	for i in get_child_count():
		get_child(i).queue_free()
	for i in SkillData[StringName(type)]:
		if i !="none":
			var button=Button.new()
			button.name=i
			button.custom_minimum_size=Vector2(400,40)
			button.text=i
			var callback = func(): SkillEditor._on_TypeButtons_pressed(i)
			button.connect("pressed",callback)
			add_child(button)



