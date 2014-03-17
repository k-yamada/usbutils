require "libusb"
require "pp"

require "usbutils/version"
require "usbutils/cli"

module USBUtils
  class << self
    def find_by(by, value)
      devices.each do |device|
        return device if device[by.to_sym] == value
      end
      raise "device not found: #{by}:#{value}"
    end

    def devices
      devices = []
      Dir.glob("/sys/bus/usb/devices/usb*") do |device|
        set_device(devices, device, 0, 0)
      end
      usb = LIBUSB::Context.new
      usb.devices.each do |usbdev|
        idvendor  = format("%04x", usbdev.idVendor)
        idproduct = format("%04x", usbdev.idProduct)
        device = devices.select {|item| item[:idvendor] == idvendor && item[:idproduct] == idproduct}.first
        device[:usbdev] = usbdev if device
      end
      devices
    end

    def set_device(devices, devpath, parent, level)
      return unless FileTest::directory?(devpath)
      Dir.chdir(devpath) do
        next unless File.exists? "busnum"
        busnum = `cat busnum`.chomp
        if File.exists? "serial"
          devnum       = `cat devnum`.chomp
          idvendor     = `cat idVendor`.chomp
          idproduct    = `cat idProduct`.chomp
          manufacturer = `cat manufacturer`.chomp
          product      = `cat product`.chomp
          serial       = `cat serial`.chomp
          devices << {
            :serial       => serial,
            :idvendor     => idvendor,
            :idproduct    => idproduct,
            :manufacturer => manufacturer,
            :product      => product,
          }
        end
        Dir.glob("#{devpath}/#{busnum}-*") do |subdev|
          subdev = subdev.chomp
          set_device devices, subdev, devnum, level + 1
        end
      end
    end
  end
end
