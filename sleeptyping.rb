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
        c = h.interrupt_transfer(
                :endpoint => ep,
                :dataIn   => 8,
                :timeout  => 1000
        )
        p c
  rescue LIBUSB::ERROR_TIMEOUT
  end
end
