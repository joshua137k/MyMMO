extends Control

@export var view:Node3D
@export var viewPort:SubViewport
@onready var skill_itemNode = preload("res://Sceane/Skills/Skill_Item.tscn")
@export var TypeContainer:VBoxContainer
var typeSkill = 0
var typeStringSkill = ["magic", "ball"]
var Elements:SkillData.Element = SkillData.Element.none
# Called when the node enters the scene tree for the first time.




func _ready()->void:
	$SkillImage.texture = viewPort.get_texture()
	_on_magic_pressed()

func _on_close_pressed()->void:
	visible=false


func _on_magic_pressed()->void:
	if typeSkill!=SkillData.ultimo and view.get_child_count()==0:
		createSkill("magic_ball")
	if view.get_child_count()!=0:
		view.get_child(0).queue_free()
		createSkill("magic_ball")


func _on_TypeButtons_pressed(extra_arg_0:String)->void:
	var a = extra_arg_0.split("_")
	typeStringSkill=a
	typeSkill=SkillData[StringName(a[0]+"_Attacks")][StringName(extra_arg_0)]
	if view.get_child_count()!=0:
		view.get_child(0).queue_free()
		createSkill(extra_arg_0)


func _on_elements_pressed(extra_arg_0)->void:
	Elements=SkillData.Element[StringName(extra_arg_0)]
	if view.get_child_count()!=0:
		view.get_child(0).setParticle(SkillData.elements_db[Elements].assestMagic,SkillData.elements_db[Elements].color)


func createSkill(type:String)->void:
	var t = type.split("_")
	type =t[0]
	typeStringSkill=t
	TypeContainer.reload(type+"_Attacks")
	var s=type+"_attacks_db"
	var new = SkillData[StringName(s)][typeSkill].assest3D
	new=new.instantiate()
	view.add_child(new)
	if Elements!=SkillData.Element.none:
		new.setParticle(SkillData.elements_db[Elements].assestMagic,SkillData.elements_db[Elements].color)


func _on_melee_pressed(extra_arg_0):
	if typeSkill!=SkillData.ultimo and view.get_child_count()==0:
		createSkill(extra_arg_0)
	if view.get_child_count()!=0:
		
		view.get_child(0).queue_free()
		createSkill(extra_arg_0)



func _on_save_pressed():

	var new = skill_itemNode.instantiate()
	new.itemInSLot=false
	new.position=get_viewport().get_mouse_position()
	new.texture=load("res://icon.svg")
	get_parent().add_child(new)
	if Elements!=SkillData.ultimo:
		typeStringSkill.append(str(Elements))
		new.type=typeStringSkill
	else:
		new.type=typeStringSkill
	clear()



func clear():
	Elements=SkillData.Element.none
	_on_magic_pressed()
	#view.get_child(0).newcolor(Color("ffffff"))
	
