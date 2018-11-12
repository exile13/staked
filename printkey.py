#!/usr/bin/env python3
import configparser
import sys

# read configuration file
ADDRESS = 'ADDRESS'
config = configparser.ConfigParser()
config.read('config.ini')

# read value to print from key
try:
    valuetoprint = sys.argv[1]
except:
    sys.exit(0)

# print the key asked for
if valuetoprint == 'pub':
    print(config[ADDRESS]['btcpubkey'])
if valuetoprint == 'wif':
    print(config[ADDRESS]['wifkey'])
if valuetoprint == 'Radd':
    print(config[ADDRESS]['Radd'])
