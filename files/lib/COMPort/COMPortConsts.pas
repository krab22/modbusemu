unit COMPortConsts;

{$mode objfpc}{$H+}

interface

const

  csLinuxCOMMPath     = '/dev/';
  csLinuxCOMMPrefix0  = 'ttyS';    // Standard UART 8250 and etc.
  csLinuxCOMMPrefix1  = 'ttyO';    // OMAP UART 8250 and etc.
  csLinuxCOMMPrefix2  = 'ttyUSB';  // Usb/serial converters PL2303 and etc.
  csLinuxCOMMPrefix3  = 'ttyACM';  // CDC_ACM converters (i.e. Mobile Phones).
  csLinuxCOMMPrefix4  = 'ttyGS';   // Gadget serial device (i.e. Mobile Phones with gadget serial driver).
  csLinuxCOMMPrefix5  = 'ttyMI';   // MOXA pci/serial converters.
  csLinuxCOMMPrefix6  = 'ttymxc';  // Motorola IMX serial ports (i.e. Freescale i.MX).
  csLinuxCOMMPrefix7  = 'ttyAMA';  // AMBA serial device for embedded platform on ARM (i.e. Raspberry Pi).
  csLinuxCOMMPrefix8  = 'ttyTHS';  // Serial device for embedded platform on ARM (i.e. Tegra Jetson TK1).
  csLinuxCOMMPrefix9  = 'rfcomm';  // Bluetooth serial device.
  csLinuxCOMMPrefix10 = 'ircomm';  // IrDA serial device.
  csLinuxCOMMPrefix11 = 'tnt';     // Virtual tty0tty serial device.

  csWindowsCOMMPath       = '\\.\';
  csWindowsCOMMPrefix     = 'COM';
  csWindowsCOMMRegKey     = 'HARDWARE\DEVICEMAP\SERIALCOMM';
  csWindowsCOMMRegSection = 'HKEY_LOCAL_MACHINE';

implementation

end.

