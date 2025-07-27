extends Node

func sum(array):
	var total = 0
	for value in array:
		total += value
	return total
	
func weighted_choice(weights=[]):
	var sum_of_weights=sum(weights)*randf()
	for i in weights.size():
		#print(sum_of_weights,weights)
		sum_of_weights-=weights[i]
		if sum_of_weights<=0:
			return i


var orders_completed=0
var money=100000000
var offered_requests=[]
class Need:
	# Min obtaining level, how hard is it to obtain in bulk, 
	var liquid_distrib=[
		[0,0.2],
		[2,0.9],
		[14,2.],
		[6,1.5],
		[25,8.],#
		[6,1.2],#
		[5,0.9],#
		[20,4.],
		[1000000,999999] #Unobtainable Lythosine
	]
	var request: Dictionary
	var money_for_this: int
	func _init(level):
		var taken_level=randi_range(floor(level/2),level)
		var mutagen=int(pow(taken_level,1.3)*1.6+5.6)
		var available_liquid_distrib=[]
		var weight_array=[]
		for i in liquid_distrib.size():
			if liquid_distrib[i][0]<=taken_level:
				available_liquid_distrib.append([i,liquid_distrib[i]])
				weight_array.append(taken_level-liquid_distrib[i][0]+1)
		request={}
		money_for_this=mutagen*3
		while mutagen>0:
			var chosen_liquid=Order.weighted_choice(weight_array)
			var spent_mutagen=randi_range(1,mutagen)
			var needed_liquid=floor(spent_mutagen/available_liquid_distrib[chosen_liquid][1][1])
			if not available_liquid_distrib[chosen_liquid][0] in request:
				request[available_liquid_distrib[chosen_liquid][0]]=needed_liquid
			else:
				request[available_liquid_distrib[chosen_liquid][0]]+=needed_liquid
			mutagen-=spent_mutagen
	func complete():
		Order.money+=money_for_this
		Order.orders_completed+=1
	func check_if_can_be_completed(storage):
		var needed_items=request.duplicate(true)
		for i in storage:
			for ii in needed_items:
				if Global.liquid_map_name_to_id[i]==ii:
					needed_items[ii]=max(0,needed_items[ii]-storage[i])
		for i in needed_items:
			if needed_items[i]>0:
				return false
		return true
func _ready():
	for i in range(3):
		offered_requests.append(Need.new(orders_completed))
func add_new_quest():
	offered_requests.append(Need.new(orders_completed))
