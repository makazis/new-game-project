extends Node

var debug_mode=false

var sandbox_mode=false

var alchemist_mode=true
 #You can add new liquids using this, allows you to see the inventory screen for this. 

var mode="Normal"

var inv_menus=[
	Vector2(0,0),
	Vector2(1,0)
]

var achievement_log={}
func log_achievement(achievement):
	if achievement["Type"]=="Created Liquid":
		achievement_log["Created "+achievement["Liquid"]]=Global.clocked_timer

func trigger_on_exit():
	var file = FileAccess.open("user://save.json", FileAccess.WRITE)
	file.store_line(JSON.stringify(achievement_log))
	file.close()
	print(achievement_log)
func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		trigger_on_exit()
		get_tree().quit() # default behavior
		
func _ready() -> void:
	if alchemist_mode:
		inv_menus.append(Vector2(1,-1))
		
	
