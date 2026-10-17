---
name: eurorack-hardware
description: "Conventions for designing eurorack hardware."
---

# Eurorack hardware engineering

## Tools to use

- Use `make` and Makefiles to automate the hardware build pipeline.
- Use `python3` for scripting.
- Use atopile for schematic design and export to KiCad.
- Use KiCad for PCB design.
- Use headless FreeRouting for PCB routing.
- Publish final exported hardware artifacts through GitHub Releases.

## Power specifications

- Use a shrouded 2.54 mm pitch IDC socket for the power connection
- Specify 10-pin power headers as 2×5 pins with 2.54 mm pitch: pins 1–2 = −12 V (red stripe), pins 3–8 = GND, pins 9–10 = +12 V.
- Specify 16-pin power headers as 2×8 pins with 2.54 mm pitch: pins 1–2 = −12 V (red stripe), pins 3–8 = GND, pins 9–10 = +12 V, pins 11–12 = +5 V, pins 13–14 = CV, pins 15–16 = Gate.
- Prefer onboard voltage regulators over a 16-pin power header for additional supply voltages.
- Clearly mark the −12 V (red-stripe) end of each power header on the PCB silkscreen.

## Signal specifications

## Clearences and dimensions

## Common components

## Part sourcing

## Schematics structuring

## Panel design rules

## Board design rules

### PCB layout rules

### PCB routing rules

## Fabrication
