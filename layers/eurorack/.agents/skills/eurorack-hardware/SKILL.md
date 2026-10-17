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

- Use 1 V/oct for pitch CV: each +1 V doubles the oscillator frequency.
- Target +5 V for gate and trigger outputs.
- Target 10 Vpp (−5 V to +5 V) for audio outputs.
- Target −5 V to +5 V for bipolar CV outputs (e.g., LFOs) and 0 V to +5 V for unipolar CV outputs (e.g., envelopes).

## Clearences and dimensions

- Use a panel height of 128.5 mm for 3U modules.
- Take panel width from the `actual module width [mm]` column in [Doepfer’s Table 1](https://doepfer.de/a100_man/a100m_e.htm).
- Use M3×6 mounting screws with horizontal mounting slots 6 mm wide and 3.2 mm high.
- Position mounting-slot centres 3 mm from the top and bottom panel edges; set the left slot centres 7.5 mm from the left edge.
- Position the right mounting-slot centres at `xRightCenterPos = 7.5 + 5.08 * (<module_hp> - 3)` mm, measured from the left panel edge.

## Common components

### Mechanical parts

#### Jacks

- Prefer PJ398SM (QingPu WQP518MA aka “Thonkiconn”) 3.5 mm mono switching jacks for PCB mounting: 10 mm effective body height, 4.5 mm thread length, and a 6 mm panel hole. [Datasheet](https://www.thonk.co.uk/wp-content/uploads/2018/07/Thonkiconn_Jack_Datasheet-new.jpg).
- Use PJ301BM (QingPu WQP518MA-BM) as an alternative 3.5 mm mono switching PCB jack with two GND pins: 11.5 mm effective body height, 4.5 mm thread length, and a 6 mm panel hole. [Datasheet](https://www.exploding-shed.com/thumbnail/f9/e2/24/1775034136/2473-100522-D_1920x1920.png).
- Use [AudioJacks](https://github.com/clacktronics/AudioJacks) KiCad footprints and 3D models: `Jack_3.5mm_QingPu_WQP-PJ398SM_Vertical` for PJ398SM (“Thonkiconn”) and `Jack_3.5mm_QingPu_WQP-PJ301BM_Vertical` for PJ301BM.

## Part sourcing

## Schematics structuring

## Panel design rules

## Board design rules

### PCB layout rules

### PCB routing rules

## Fabrication
