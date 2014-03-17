# -*- coding: utf-8 -*-
require 'usbutils'
require 'thor'

module USBUtils
  class CLI < Thor
    desc "devices", "list all usb devices"
    option :detail, :aliases => "d"
    def devices
      devices = USBUtils.devices
      USBUtils.devices.each do |device|
        if options[:detail]
          pp device
        else
          print "serial=#{device[:serial]}\tproduct=#{device[:product]}\tmanufacturer=#{device[:manufacturer]}\n"
        end
      end
    end

    desc "reset <serial no>", "reset device"
    def reset(serial)
      device = USBUtils.find_by(:serial, serial)
      device[:usbdev].open.reset_device
    end
  end
end
