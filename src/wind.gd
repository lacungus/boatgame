var amplitude
var period

func _init(amplitude, period):
	self.amplitude = amplitude
	self.period = period
	
func get_strength(t):
	return amplitude * t * sin(period * t)
