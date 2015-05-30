require "libusb"

def print_input(c)
	keycode = ['None','None','None','None','a','b','c','d','e','f', #0-9
	  'g','h','i','j','k','l','m','n','o','p', #10-19
	  'q','r','s','t','u','v','w','x','y','z', #20-29
	  '1','2','3','4','5','6','7','8','9','0', #30-39
	  'Enter','Esc','Bksp','Tab','Space','None','None','@','[','None', #40-49
	  ']',';','*','hz','<','>','/','Caps','F1','F2', #50-59
	  'F3','F4','F5','F6','F7','F8','F9','F10','F11','F12', #60-69
	  'PrtSc','ScLk','PsBk','Ins','Home','PgUp','Del','End','PgDn','right', #7
	  'left','down','up','NumLock','n/','n*','n-','n+','nEnt','n1', #8
	  'n2','n3','n4','n5','n6','n7','n8','n9','n0','n.', #9
	  'None','Mark','None','None','None','None','None','None','None','None', #10
	  'None','None','None','None','None','None','None','None','None','None', #11
	  'None','None','None','None','None','None','None','None','None','None', #12
	  'None','None','None','None','None','None','None','\\','MHR','MHL', #13
	  'None','None','None','None','None','None','None','None','None','None', #14
	  'None','None','None','None','None','None','None','None','None','None', #15
	  'None','None','None','None','None','None','None','None','None','None', #16
	  'None','None','None','None','None','None','None','None','None','None', #17
	  'None','None','None','None','None','None','None','None','None','None', #18
	  'None','None','None','None','None','None','None','None','None','None', #19
	  'None','None','None','None','None','None','None','None','None','None', #20
	  'None','None','None','None','None','None','None','None','None','None', #21
	  'None','None','None','None','None','None','None','None','None','None', #22
	  'None','None','None','None','None','None','None','None','None','None', #23
	  'None','None','None','None','None','None','None','None','None','None', #24
	  'None','None','None','None','None','None' #25
	]
	keyX = [
	  0,0,0,0,26,81,57,49,48,61, #0-9
	  72,84,106,96,107,119,104,93,117,129, #10-19
	  25,59,28,71,94,69,36,46,83,35, #20-29
	  19,31,42,54,65,77,88,100,112,124, #30-39
	  167,8,169,11,75,0,0,141,152,0, #40-49
	  154,130,142,8,116,127,139,10,32,43, #50-59
	  55,66,83,95,106,128,135,147,158,169, #60-69
	  185,197,208,185,197,208,185,197,208,202, #70-79
	  191,197,197,224,235,247,258,258,258,224, #80-89
	  235,247,224,235,247,224,235,247,230,247, #90-99
	  0,155,0,0,0,0,0,0,0,0, #100-109
	  0,0,0,0,0,0,0,0,0,0, #110-119
	  0,0,0,0,0,0,0,0,0,0, #120-129
	  0,0,0,0,0,0,0,158,108,52, #130-139
	  0,0,0,0,0,0,0,0,0,0, #140-149
	  0,0,0,0,0,0,0,0,0,0, #150-159
	  0,0,0,0,0,0,0,0,0,0, #160-169
	  0,0,0,0,0,0,0,0,0,0, #170-179
	  0,0,0,0,0,0,0,0,0,0, #180-189
	  0,0,0,0,0,0,0,0,0,0, #190-199
	  0,0,0,0,0,0,0,0,0,0, #200-209
	  0,0,0,0,0,0,0,0,0,0, #210-219
	  0,0,0,0,0,0,0,0,0,0, #220-229
	  0,0,0,0,0,0,0,0,0,0, #230-239
	  0,0,0,0,0,0,0,0,0,0, #240-249
	  0,0,0,0,0,0 #250-255
	]
	keyY = [
	   0, 0, 0, 0,31,20,20,31,43,31, #0-9
	  31,31,43,31,31,31,20,20,43,43, #10-19
	  43,43,31,43,43,20,43,20,43,20, #20-29
	  54,54,54,54,54,54,54,54,54,54, #30-39
	  37,73,54,43, 9, 0, 0,43,43, 0, #40-49
	  31,31,31,54,20,20,20,31,73,73, #50-59
	  73,73,73,73,73,73,73,73,73,73, #60-69
	  54,54,54,43,43,43,31,31,31,15, #70-79
	  15, 9,20,54,54,54,54,37,15,20, #80-89
	  20,20,31,31,31,43,43,43, 9, 9, #90-99
	   0, 9, 0, 0, 0, 0, 0, 0, 0, 0, #100-109
	  0,0,0,0,0,0,0,0,0,0, #110-119
	  0,0,0,0,0,0,0,0,0,0, #120-129
	  0,0,0,0,0,0,0,54,9,9, #130-139
	  0,0,0,0,0,0,0,0,0,0, #140-149
	  0,0,0,0,0,0,0,0,0,0, #150-159
	  0,0,0,0,0,0,0,0,0,0, #160-169
	  0,0,0,0,0,0,0,0,0,0, #170-179
	  0,0,0,0,0,0,0,0,0,0, #180-189
	  0,0,0,0,0,0,0,0,0,0, #190-199
	  0,0,0,0,0,0,0,0,0,0, #200-209
	  0,0,0,0,0,0,0,0,0,0, #210-219
	  0,0,0,0,0,0,0,0,0,0, #220-229
	  0,0,0,0,0,0,0,0,0,0, #230-239
	  0,0,0,0,0,0,0,0,0,0, #240-249
	  0,0,0,0,0,0 #250-255
	]
	if keycode[c] != 'None' then
		t = Time.now
		tu = t.to_i*1000 + t.usec/1000
	
		data = tu.to_s+","+keycode[c]+","+keyX[c].to_s+","+keyY[c].to_s+","+ARGV[0]+"\n"
		f = File.open($filename, "a")
		f.write(data)
		f.close
		puts data
	end
end

kbnum = ARGV[0].to_i

u = LIBUSB::Context.new
d = u.devices[kbnum]
h = d.open
i = d.interfaces[0]
ep = i.endpoints.first

begin
  h.claim_interface(0)
rescue LIBUSB::ERROR_BUSY
  h.detach_kernel_driver(0)
  h.claim_interface(0)
end

dir = File::dirname(__FILE__) + "/data/" 
$filename = Time.now.strftime(dir + "%Y%m%d_%H%M_"+kbnum.to_s+".csv")

while true do
  begin
        s = h.interrupt_transfer(
                :endpoint => ep,
                :dataIn   => 16,
                :timeout  => 1000
        )
        s.bytes {|b| print_input(b) if b != 0}
  rescue LIBUSB::ERROR_TIMEOUT
  end
end
