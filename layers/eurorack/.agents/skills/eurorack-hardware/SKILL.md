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

### Panel components

#### Jacks

- Prefer PJ398SM (QingPu WQP518MA aka “Thonkiconn”) 3.5 mm mono switching jacks for PCB mounting: 10 mm effective body height, 4.5 mm thread length, and a 6 mm panel hole. [Datasheet](https://www.thonk.co.uk/wp-content/uploads/2018/07/Thonkiconn_Jack_Datasheet-new.jpg).
- Use PJ301BM (QingPu WQP518MA-BM) as an alternative 3.5 mm mono switching PCB jack with two GND pins: 11.5 mm effective body height, 4.5 mm thread length, and a 6 mm panel hole. [Datasheet](https://www.exploding-shed.com/thumbnail/f9/e2/24/1775034136/2473-100522-D_1920x1920.png).
- Use [AudioJacks](https://github.com/clacktronics/AudioJacks) KiCad footprints and 3D models: `Jack_3.5mm_QingPu_WQP-PJ398SM_Vertical` for PJ398SM (“Thonkiconn”) and `Jack_3.5mm_QingPu_WQP-PJ301BM_Vertical` for PJ301BM.

#### Potentiometers

- Default to Alpha RD901F vertical potentiometers with a T18 shaft and M7×0.75 threaded bushing: 10 mm body height, 6 mm shaft diameter, 15 mm full shaft length, and a 7.5 mm panel hole. Select resistance and taper (B = linear, A = logarithmic) to suit the circuit. [Datasheet](https://www.thonk.co.uk/wp-content/uploads/2017/12/Alpha-9mm-Vertical-T18-RD901F-40-15K-B50K-0057.pdf) · [Shop](https://www.thonk.co.uk/shop/alpha-9mm-pots-vertical-t18/).
- Use Song Huei R0904N vertical 9 mm snap-in tall trimmers for secondary controls such as CV attenuation: 6 mm diameter round knurled shaft, 17.2 mm full shaft length, white indicator line, and no separate knob required. Select resistance and taper (B = linear, A = logarithmic) to suit the circuit. [Datasheet](https://www.thonk.co.uk/wp-content/uploads/2014/10/R0904N_Thonk.pdf) · [Shop](https://www.thonk.co.uk/shop/ttpots/).

#### Slide potentiometers

- Use Bourns PTA carbon slide potentiometers with metal housings and 15 mm shafts; select resistance and travel (15, 20, 30, 45, or 60 mm) to suit the circuit. Source from Mouser. Example: `PTA3043-2015CIB503` (50 kΩ linear, 30 mm travel, single gang, no detent, 15 mm shaft). [Datasheet](https://www.bourns.com/docs/product-datasheets/pta.pdf).
- Use Alpha RAXX45F-20 LED slide potentiometers with the `15LC` 15 mm shaft option; choose 20, 25, 30, or 45 mm travel and amber, blue, green, or red LEDs. Example: `RA2045F-20A-15LC-B10K` (10 kΩ linear, 20 mm travel, amber LED, 15 mm shaft). [Datasheet](https://www.taiwanalpha.com/downloads?id=164&target=products).

#### Switches

- Use Dailywell 2M series sub-miniature PCB toggle switches from Thonk: SPDT ON-ON, SPDT ON-OFF-ON, DPDT ON-ON, or DPDT ON-OFF-ON. Allow 8.64 mm body depth, 5.59 mm bushing length, and a 9.40 mm lever; the bushing thread is 10-48 UNS-2A. Use the datasheet’s 4.95 mm diameter D-shaped panel cutout, measuring 4.55 mm from the flat to the opposite edge, or its locking-ring mounting layout. Use 2.54 mm pin spacing: SPDT has one row of three pins; DPDT has two rows of three pins, 5.08 mm apart. Common terminals are pin 2 for SPDT and pins 2 and 5 for DPDT. Datasheets: [SPDT ON-ON](https://www.thonk.co.uk/wp-content/uploads/2017/05/DW1-SPDT-ON-ON-2MS1T1B1M2QES.pdf), [SPDT ON-OFF-ON](https://www.thonk.co.uk/wp-content/uploads/2017/05/DW2-SPDT-ON-OFF-ON-2MS3T1B1M2QES.pdf), [DPDT ON-ON](https://www.thonk.co.uk/wp-content/uploads/2017/05/DW3-DPDT-ON-ON-2MD1T1B1M2QES.pdf), [DPDT ON-OFF-ON](https://www.thonk.co.uk/wp-content/uploads/2017/05/DW4-DPDT-ON-OFF-ON-2MD3T1B1M2QES.pdf) · [Shop](https://www.thonk.co.uk/shop/sub-mini-toggle-switches/).

#### Buttons

- Use E-Switch TL1105SPF100Q momentary SPST-NO tactile buttons: 6 × 6 mm body. Fit 1R series caps (nominal 5 mm diameter); capped assembly height is 13.6 mm above the PCB. [Datasheet](https://configured-product-images.s3.amazonaws.com/2D/specs/TL1105SPF100Q.pdf) · [1R caps](https://www.e-switch.com/product/1r/) · [Capped assembly](https://configured-product-images.s3.amazonaws.com/2D/specs/TL1105SPF100Q1RBLK.pdf).
- Use Thonk low-profile illuminated LED buttons with momentary SPST-NO action: 7.5 × 7.5 mm top flange and a 5.5 mm diameter actuator. Choose red, green, blue, yellow, orange, white, or bipolar red/green LEDs. Use the supplied `SW_Tact_Low_Profile_LED_ExtraHoles` KiCad footprint so the three underside protrusions sit in PCB holes and match Thonkiconn jack mounting height. [Datasheet](https://www.thonk.co.uk/wp-content/uploads/2021/12/LowProfileButton.pdf) · [KiCad footprints and 3D model](https://www.thonk.co.uk/wp-content/uploads/2025/10/THONK-SW-LP-LED-KICAD.zip) · [Shop](https://www.thonk.co.uk/shop/low-profile-led-buttons/).

#### LEDs

- Always use 3 mm (T-1) through-hole LEDs.
- Prefer Kingbright cylindrical LEDs: WP424GDT (green), WP424IDT (red), and WP424YDT (yellow). [WP424YDT datasheet](https://www.kingbrightusa.com/images/catalog/spec/wp424ydt.pdf).
- Use Kingbright WP3VEGW for red/green bi-colour indication with three leads and a common cathode. [Datasheet](https://www.kingbrightusa.com/images/catalog/SPEC/WP3VEGW.pdf).
- Use Kingbright WP937EGW as the two-lead red/green bi-colour option. [Datasheet](https://www.kingbrightusa.com/images/catalog/spec/wp937egw.pdf).
- For other 3 mm LED options, refer to the [Kingbright through-hole LED catalog](https://kingbright-europe.de/wp-content/uploads/2024/10/P24-33-THROUGH-HOLE-LEDKBE-Link.pdf).

#### Encoders

- Default to TT Electronics EN11-HSM encoders: top-adjust, with push switch and M7×0.75 threaded bushing. Prefer 20 detents, a 5 mm bushing, and a 15 mm shaft. Choose a 6 mm D-shaft (`F`) or knurled shaft (`Q`); preferred part: `EN11-HSM1AQ15`. [Datasheet](https://www.ttelectronics.com/TTElectronics/media/ProductFiles/Datasheets/EN11.pdf).
- Use Bourns PEC11R series encoders as an alternative. [Datasheet](https://www.bourns.com/docs/product-datasheets/pec11r.pdf).

## Part sourcing

## Schematics structuring

## Panel design rules

## Board design rules

### PCB layout rules

### PCB routing rules

## Fabrication
