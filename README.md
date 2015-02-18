# USBUtils

Utilities to control the USB devices.

## Installation

    $ gem install usbutils

## Usage

show command list

    $ usbutils
    Commands:
    usbutils devices            # list all usb devices
    usbutils help [COMMAND]     # Describe available commands or one specific command
    usbutils reset <serial no>  # reset device

show usb devices

    $ sudo usbutils devices
    serial=0000:00:06.0	product=OHCI Host Controller	manufacturer=Linux 3.2.0-23-generic ohci_hcd
    serial=01498A4D15005015	product=Galaxy Nexus	manufacturer=samsung

reset(reconnect) usb device

    $ sudo usbutils reset 01498A4D15005015


## usbreset by C lang

http://askubuntu.com/questions/645/how-do-you-reset-a-usb-device-from-the-command-line

## Contributing

1. Fork it ( http://github.com/<my-github-username>/usbutils/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
