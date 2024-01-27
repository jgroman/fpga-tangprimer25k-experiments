# 03_UART_loopack

Built-in UART RX <-> TX loopback. Whatever is received is being transmitted back.

This project can be used for setting up and testing of tools for serial communication with the board. If you have everything set up correctly, you should see every typed characters being displayed on the console without having Local Echo switched on.

Please note that Tang Primer 25K board provides programming interface (`/dev/ttyUSB<x>`) and serial connection (`/dev/ttyUSB<x+1>`) on the same physical USB cable.

You can use for example `minicom` for connecting to the board UART:

```bash
minicom -b 115200 -o -D /dev/ttyUSB1
```

During board programming any serial connection to the board UART will be interrupted, as the programming tool requires exclusive access to the board interface.

## Gowin Programmer

On Linux the "official" Gowin programmer will check if there is no connection open to UART and then will
unload `ftdi_sio` kernel module before getting to work. Unfortunately after programming the module is not loaded back
automatically and `ttyUSB` devices will be missing.
So the complete workflow to disconnect UART and restore it after loading could look like this:

```bash
# Detach any existing serial connection
sudo usb_modeswitch -v 0x0403 -p 0x6010 --detach-only

# Load the bitstream
sudo $(GOWIN_PROGRAMMER_CLI_PATH) --device $(GOWIN_DEVICE) --run $(GOWIN_OP_SRAM_PGM) --cable-index $(GOWIN_CABLE_INDEX) --fsFile $(GOWIN_FS_FILE)

# Restore ttyUSB devices
sudo modprobe ftdi_sio
```

`minicom` is capable of automatic reconnection and your connection to the board UART will be restored.

## openFPGALoader

[openFPGALoader](https://github.com/trabucayre/openFPGALoader) handles USB interface takeover much better and during programming will just temporarily suspend serial connection which will be automatically restored afterwards.
