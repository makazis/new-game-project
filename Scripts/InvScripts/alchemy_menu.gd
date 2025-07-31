extends Control

func demiload():
	for i_ in $Panel.get_children():
		for i in i_.get_children():
			if i.has_method("demiload"):
				i.demiload()


func _on_button_pressed() -> void:
	var new_inputs={}
	var total_liquids=0
	for i in $Panel/Inputs.get_children():
		if i.item_count>0:
			if not i.selected_liquid in new_inputs:
				new_inputs[i.selected_liquid]=i.item_count
			else:
				new_inputs[i.selected_liquid]+=i.item_count
			total_liquids+=i.item_count
			if total_liquids>50:
				print("Seems that you have too many particles for the fuser to handle. Try removing some, so the recipe is actually possible.")
				return
	
	var new_outputs={}
	total_liquids=0
	for i in $Panel/Outputs.get_children():
		if i.item_count>0:
			if not i.selected_liquid in new_outputs:
				new_outputs[i.selected_liquid]=i.item_count
			else:
				new_outputs[i.selected_liquid]+=i.item_count
			total_liquids+=i.item_count
			if total_liquids>99:
				print("Bro wtf.")
				return
			elif total_liquids>50:
				print(str(total_liquids)+" particles coming out? This feels like a bit too much, as the fuser can't intake that many itself.")
				return
			elif total_liquids>20:
				print(str(total_liquids)+" particles coming out? You're on thin ice, pal.")
			elif total_liquids>10:
				print(str(total_liquids)+" particles coming out? I feel like you might want to slow down a bit buddy.")
			elif total_liquids>5:
				print(str(total_liquids)+" particles coming out? Yeah, i can see that, but don't push it friend.")
	for i in Global.crafting_tree:
		var copy_of_inputs=new_inputs.duplicate()
		var overrides=true
		var underrides=true
		for liquid in i["Req"]:
			if liquid in copy_of_inputs:
				if copy_of_inputs[liquid]<i["Req"][liquid]:
					overrides=false
			else:
				overrides=false
		for liquid in copy_of_inputs:
			if liquid in i["Req"]:
				if copy_of_inputs[liquid]>i["Req"][liquid]:
					underrides=false
			else:
				underrides=false
		if overrides:
			print("This recipe will not function due to a previous recipe, that has the following requirements: "+str(i["Req"]))
		if overrides:
			print("This recipe will make a previous recipe not function, due to it having the following requirements: "+str(i["Req"]))
		
	var new_new_outputs={}
	for i in new_outputs:
		new_new_outputs[Global.liquid_map_name_to_id[i]]=new_outputs[i]	
	print("""
	{
		"Req":"""+str(new_inputs)+""",
		"Result":"""+str(new_new_outputs)+"""
	},
	""")
	
	
