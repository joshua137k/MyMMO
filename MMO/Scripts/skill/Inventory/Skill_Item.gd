extends TextureRect
class_name skill_item

@export var get_inv:NodePath
var GetedInv:Panel 
@export var itemInSLot=true

var type:Array  = [] :
	set(value):
		type=value
		
		change()

var Elements:SkillData.Element=SkillData.Element.none


func change():
	$Panel/Label.text=str(type)
	if type.size()>2:
		$Panel/Label.text=str(type)+" "+ str(type[2])+": "+str(SkillData.elements_db[int(type[2])].name)



func _get_drag_data(_position):
	set_drag_preview(duplicate())
	if !itemInSLot:
		return [self,null]
	return [self,get_node(get_inv)]


func _on_mouse_entered():
	$Timer.start()


func _on_mouse_exited():
	$Timer.stop()
	$Panel.visible=false


func _on_timer_timeout():
	$Panel.visible=true
