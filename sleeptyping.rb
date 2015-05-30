require "libusb"

u = LIBUSB::Context.new
d = u.devices[0]
h = d.open
i = d.interfaces[0]
ep = i.endpoints.first

begin
  h.claim_interface(0)
rescue LIBUSB::ERROR_BUSY
  h.detach_kernel_driver(0)
  hs = h.claim_interface(0)
end

while true do
  begin
        s = h.interrupt_transfer(
                :endpoint => ep,
                :dataIn   => 16,
                :timeout  => 1000
        )
        s.bytes {|b| print b.to_s(10)+"\n" if b != 0}
  rescue LIBUSB::ERROR_TIMEOUT
  end
end
