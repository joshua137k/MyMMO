extends VBoxContainer




func _on_b_elements_pressed():
	if $Element.visible==false:
		$Element.visible=true
	else:
		$Element.visible=false
		


func _on_btype_pressed():
	
	if $Type.visible==false:
		$Type.visible=true
	else:
		$Type.visible=false


func _on_b_type_class_pressed():
	if $TypeSkillUser.visible==false:
		$TypeSkillUser.visible=true
	else:
		$TypeSkillUser.visible=false

