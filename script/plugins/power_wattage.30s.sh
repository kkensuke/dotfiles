#!/bin/bash
# <xbar.title>USB-C Charger Wattage with Battery</xbar.title>
# <xbar.refresh>60</xbar.refresh>
# <xbar.desc>Displays current USB-C charger wattage and battery percentage.</xbar.desc>

# Get battery percentage
BATTERY=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)

# Get charger wattage
WATTAGE=$(system_profiler SPPowerDataType | grep "Wattage" | awk '{print $3}')

if [ -z "$WATTAGE" ]; then
  # On battery
  echo "🔋 ${BATTERY}%"
else
  # Charging
  echo "⚡ ${WATTAGE}W ${BATTERY}%"
fi
