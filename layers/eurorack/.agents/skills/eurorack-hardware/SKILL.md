---
name: eurorack-hardware
description: "Guidelines and conventions to design Eurorack hardware using atopile and KiCad, including component sourcing, panel and stacked-PCB design, and JLCPCB fabrication preparation."
---

# Eurorack hardware engineering

Use these conventions to design and review manufacturable Eurorack modules. They cover electrical interfaces, component selection and sourcing, schematics, panels, stacked PCBs, and fabrication handoff through a reproducible atopile/KiCad build pipeline.

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
- Budget worst-case current for each supply rail and connector; check regulator dissipation and dropout, including voltage losses in protection diodes and supply filters.
- Clearly mark the −12 V (red-stripe) end of each power header on the PCB silkscreen.
- Protect both +12 V and −12 V supply inputs against reversed polarity.

## Signal specifications

- Use 1 V/oct for pitch CV: each +1 V doubles the oscillator frequency.
- Target +5 V for gate and trigger outputs.
- Target 10 Vpp (−5 V to +5 V) for audio outputs.
- Target −5 V to +5 V for bipolar CV outputs (e.g., LFOs) and 0 V to +5 V for unipolar CV outputs (e.g., envelopes).
- Protect inputs against accidental ±12 V patching; make outputs tolerant of shorts to ground and connections to other outputs.
- Buffer audio and CV interfaces as needed; target ≥100 kΩ input impedance and ≤1 kΩ output impedance, with ≤100 Ω effective output impedance for 1 V/oct CV outputs. Preserve pitch accuracy under load, short-circuit protection, and stability with patch-cable capacitance. [Doepfer](https://doepfer.de/a1803.htm) · [North Coast Synthesis](https://northcoastsynthesis.com/news/all-about-levels/).
- Scale and, where necessary, offset CV inputs into the ADC’s usable range without clipping intended signals; calculate input impedance and filter response using the full source, divider, and load network.
- For MIDI inputs, use optoisolation and avoid a direct DC connection from the input shield/sleeve to local ground; follow the [MIDI electrical specification](https://www.midi.org/wp-content/uploads/wpforo/default_attachments/1709416667-ca33-MIDI-10-Electrical-Specification-Update.pdf).

## Clearences and dimensions

- Use a panel height of 128.5 mm for 3U modules.
- Take panel width from the `actual module width [mm]` column in [Doepfer’s Table 1](https://doepfer.de/a100_man/a100m_e.htm).
- Use M3×6 mounting screws with horizontal mounting slots 6 mm wide and 3.2 mm high.
- Position mounting-slot centres 3 mm from the top and bottom panel edges; set the left slot centres 7.5 mm from the left edge.
- Position the right mounting-slot centres at `xRightCenterPos = 7.5 + 5.08 * (<module_hp> - 3)` mm, measured from the left panel edge.

## Common components

Preferred components and selection guidelines for Eurorack designs, including package choices, mechanical dimensions, and links to datasheets and KiCad libraries.

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

- Use Dailywell 2M series sub-miniature PCB toggle switches from Thonk: SPDT ON-ON, SPDT ON-OFF-ON, DPDT ON-ON, or DPDT ON-OFF-ON. Allow 8.64 mm body depth, 5.59 mm bushing length, and a 9.40 mm lever; the bushing thread is 10-48 UNS-2A. Use a round 5 mm diameter panel cutout. Use 2.54 mm pin spacing: SPDT has one row of three pins; DPDT has two rows of three pins, 5.08 mm apart. Common terminals are pin 2 for SPDT and pins 2 and 5 for DPDT. Datasheets: [SPDT ON-ON](https://www.thonk.co.uk/wp-content/uploads/2017/05/DW1-SPDT-ON-ON-2MS1T1B1M2QES.pdf), [SPDT ON-OFF-ON](https://www.thonk.co.uk/wp-content/uploads/2017/05/DW2-SPDT-ON-OFF-ON-2MS3T1B1M2QES.pdf), [DPDT ON-ON](https://www.thonk.co.uk/wp-content/uploads/2017/05/DW3-DPDT-ON-ON-2MD1T1B1M2QES.pdf), [DPDT ON-OFF-ON](https://www.thonk.co.uk/wp-content/uploads/2017/05/DW4-DPDT-ON-OFF-ON-2MD3T1B1M2QES.pdf) · [Shop](https://www.thonk.co.uk/shop/sub-mini-toggle-switches/).

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

#### Displays

- Assess and select displays individually for each module.

### Connectors & standoffs

- Default to single- or double-row, 2.54 mm pitch through-hole pin headers and sockets for board-to-board connections.
- Use M2.5 or M3 brass hex standoffs.

### Passive components & semiconductors

- Use SMD components. Only resort to through-hole components if there is no SMD equivalent.
- Choose 0603 or 0402 as the default resistor and capacitor package size and use it consistently, unless requirements such as voltage rating demand a different package.
- Default to 1% resistors; select tighter tolerances and low-temperature-coefficient parts where CV/pitch accuracy requires them.
- Prefer C0G/NP0 for timing and precision filters and X7R for decoupling; account for DC-bias capacitance loss in X7R capacitors.
- Use electrolytic capacitors with a DC voltage rating of at least 25 V.
- Evaluate common parts(their SMD equivalents) before choosing specialized parts: 2N3904/2N3906 transistors; 1N4148, BAT54S, and 1N5819 diodes; LM13700 OTAs; TL072, TL074, and MCP6002 op-amps; MCP3204 ADCs; DAC8551 DACs; LM4040 voltage references; LM393B/LM339B comparators; CD4051B/CD4053B analog multiplexers; 74HC165/74HC595 shift registers; and 78L05/79L05 voltage regulators.
- Prefer STM32 32-bit Arm Cortex microcontrollers; choose alternatives only for a clear, justified reason.
- Use Recom R-78E Series for DC-to-DC conversion (12V to 5V or 3.3V)

## Part sourcing

- Use JLCPCB as the default PCBA service and its [in-stock parts library](https://jlcpcb.com/parts/in-stock-parts) as the primary source for SMD components.
- Use [Mouser](https://eu.mouser.com/en/) or [DigiKey](https://www.digikey.com/) as secondary sources, including for through-hole and mechanical parts, and for researching components and alternatives.
- Use [Thonk](https://www.thonk.co.uk/) for Eurorack-specific components such as jacks, switches, and buttons.
- Use [Waveshare](https://www.waveshare.com/) for displays and development boards.
- Before finalizing the BOM, verify assembly eligibility and stock for the planned batch, including assembly-loss allowances. [JLCPCB guidance](https://jlcpcb.com/help/article/common-bom-and-cpl-matching-issues-and-explanations).
- Record matching manufacturer identities, exact part numbers, supplier codes, and product links in component definitions and the BOM; include valid JLCPCB/LCSC C-codes for PCBA parts and document substitutions. [BOM guidance](https://jlcpcb.com/help/article/bill-of-materials-for-pcb-assembly).
- Mark externally sourced and hand-fitted parts explicitly in the BOM and assembly instructions; never use placeholder supplier codes.
- Compare total component and assembly costs, accounting for Basic/Extended classifications and service-dependent feeder-loading fees. [Assembly pricing](https://jlcpcb.com/help/article/pcb-assembly-price).
- Never place orders to source parts or samples yourself.

## Schematics design & structuring

- Keep components within datasheet-recommended operating conditions across expected supply, signal, load, and tolerance ranges.
- Check converter and amplifier headroom using actual supplies after protection and filtering, signal ranges, and loads. [DAC headroom example](https://www.ti.com/lit/gpn/dac80508).
- Follow datasheet decoupling requirements; default to 100 nF ceramic from each IC supply rail to GND and bulk capacitance at each board’s power entry. [Decoupling guidance](https://www.analog.com/media/en/training-seminars/tutorials/MT-101.pdf).
- Define safe startup/reset states for outputs, reset lines, and chip selects; add pull-ups/pull-downs where needed.
- Filter sensitive analog supplies shared with switching loads as needed.
- Budget pitch-CV error from references, resistor ratios, amplifier offset, converter accuracy, drift, and loading; calibrate gain/offset as needed. [Error-budget guidance](https://www.analog.com/en/resources/technical-articles/calculating-the-error-budget-in-precision-dac-apps.html).
- Provide accessible programming/debug connections and reset/bootloader controls.
- Specify electrical values with units and tolerances; encode critical limits and relationships as atopile constraints/assertions.
- Build each PCB and multi-board system after circuit changes; fix errors and document accepted warnings before layout.
- Calculate or simulate transfer functions, loading, timing, and stability outside atopile’s modeled constraints.
- Add test points for GND, supplies, references, and critical signals; document expected voltages/waveforms.
- Keep atopile sources authoritative for circuit connectivity and component specifications; regenerate KiCad outputs after circuit changes.
- Split circuits into functional atopile modules with explicit, named interfaces.
- Reuse suitable modules; instantiate repeated circuits from one parameterized definition.
- Document pin/peripheral assignments, polarity, channel/bit order, bus addresses, and initialization requirements for firmware.
- Store custom parts, reusable circuits, and board assemblies in `components/`, `circuits/`, and `boards/`; define one build entry per PCB.
- Keep each custom part’s `.ato`, KiCad symbol/footprint, available 3D model, and documentation together.
- Maintain a circuit README covering purpose, interfaces, operating ranges, key calculations, and design decisions.

### Common mistakes to avoid

- Check pin-to-pad mapping against the exact part/package datasheet; connect all required supply, GND, reference, and enable pins.
- Connect all power-header pins assigned to each used rail, including every GND pin.
- Match jack symbols to the actual tip, sleeve, and switching contacts.
- Rate I/O protection resistors and clamps for sustained shorts to either supply rail; calculate worst-case currents and dissipation.
- Clamp reverse voltage across BJT base–emitter junctions and LEDs exposed to bipolar signals.
- Use non-polar capacitors wherever voltage across the capacitor can reverse.
- Use rated fuses/PTCs when overcurrent protection is needed.
- Current-limit jack normal connections to supply rails to tolerate plug-insertion shorts.
- Limit current into shunt clipping/clamping diodes with series resistance.
- Check op-amp common-mode limits at external inputs; attenuate/clamp signals to prevent phase reversal.
- Give external inputs a DC return path so open-ended patch cables produce a defined voltage.
- Ensure gate/trigger outputs source and sink current at the required HIGH/LOW levels.
- Set unused logic and control inputs to defined states per datasheet. [Logic inputs](https://www.ti.com/lit/an/scba004e/scba004e.pdf).
- Configure unused op-amps in stable closed-loop circuits within their input/output limits. [Unused op-amps](https://www.ti.com/lit/ab/sboa204a/sboa204a.pdf).
- Calculate feedback-capacitor cutoff frequencies from actual resistor values; preserve the required bandwidth.
- Design resistor/bead supply filters for target attenuation and load current; check voltage drop.
- Choose internal feedback resistances to balance noise and driver loading. [Op-amp noise](https://www.analog.com/media/en/training-seminars/tutorials/MT-047.pdf).
- Further reading and illustrated reference: [Design mistakes in synth schematics](https://northcoastsynthesis.com/news/design-mistakes-in-synth-schematics/).

## Panel design rules

- Design first-iteration panels as FR-4 PCBs in KiCad; aluminium is an optional choice for full production.
- Use 1.6 mm panel thickness; verify shaft protrusion and nut engagement with washers fitted.
- Use a shared coordinate reference for panel cutouts, PCB footprints, and standoff holes.
- Check adjacent component spacing using datasheet body length and width; include knobs and mounting hardware in the clearance check.
- Mount the component PCB parallel behind the panel: use 10 mm PCB-to-panel spacing for Thonkiconn jacks or 11.5 mm for PJ301BM jacks. Keep other component bodies within this gap.
- Size panel cutouts for shafts and actuators using datasheet dimensions, allowing assembly clearance and full travel.
- Define rectangular cutouts for displays, SD-card slots, and USB sockets as closed outlines on `Edge.Cuts`.
- Round internal cutout corners to the fabricator’s supported milling radius; check component clearance at those corners.
- Add panel-to-PCB standoffs where extra support is needed; match their effective height to the jack-defined PCB-to-panel gap.
- Use `F.SilkS` (front silkscreen) for panel labels and decorative artwork.
- Keep labels clear of knobs, nuts, and plugs.
- Use [KiCad faceplate and PCB templates](https://github.com/JonathanBedrava/eurorack-kicad-templates) as starting points; ensure their dimensions and mounting slots fit rules above with a +-0.3mm tolerance.
- Consider [Eurorack Panel Generator](https://github.com/napolitano/eurorack-panel-generator) as another starting point for panel creation; review its noncommercial licensing before use.

## Board design rules

- Use a 110 mm PCB height for the control board (the one that sits directly behind the panel); define board outlines and stack positions with clearance for rack rails, mounting hardware, and adjacent-board components.
- Stack additional boards parallel behind the control board and panel, with 10 mm spacing between adjacent boards and the same width as the control board; use the connectors and standoffs specified in [Connectors & standoffs](#connectors--standoffs).
- Verify signal correspondence at every physical mating contact, accounting for connector pin numbering, board-side mirroring, rotation, and keying; confirm that the sandwich stack is mechanically feasible.
- Match each footprint to the exact package and datasheet land pattern, including exposed pads and mounting holes.
- Choose the copper layer count and stackup before routing; keep KiCad settings and manufacturing outputs consistent.
- Keep fabrication limits and netclasses in shared configuration; apply them consistently during export, routing, and route import.
- Mark each PCB’s name and hardware revision on unobstructed silkscreen.

### PCB layout rules

- Place and lock panel components, mating connectors, and mounting holes before arranging the remaining circuitry.
- Reserve clearance for through-hole leads and solder joints on the opposite PCB side.
- Place decoupling capacitors next to IC supply pins with short, direct supply and GND connections.
- Group each circuit’s ICs and supporting components to keep local signal paths short.
- Keep clocks, PWM, and switching-power paths away from precision analog circuitry and references. [Mixed-signal layout](https://www.analog.com/en/resources/analog-dialogue/articles/what-are-the-basic-guidelines-for-layout-design-of-mixed-signal-pcbs.html).
- Keep heat-producing regulators away from precision DACs, voltage references, and pitch-CV circuitry.
- Leave routing space around dense ICs and cable-insertion clearance around connectors.
- Create board-layout variants with 90° rotations of freely placed components to improve routing; preserve fixed positions and orientations.
- Check placements for overlaps and board-edge violations before routing, accounting for footprint origins, rotation, and board-side mirroring.

### PCB routing rules

- Run KiCad DRC after route import and zone filling; resolve violations and unconnected items before fabrication export.
- Never create DRC exceptions without explicit user approval; each exception must be individually reviewed and documented.
- Size power traces and vias for worst-case current, allowable voltage drop, and temperature rise. [TI guidance](https://www.ti.com/video/6245175641001).
- Pre-route constrained connections before autorouting; verify pad connectivity and layer transitions after route import.
- Preserve continuous GND return paths beneath signal traces; avoid crossing plane splits or voids. [Grounding guidance](https://www.analog.com/en/resources/technical-articles/successful-pcb-grounding-with-mixedsignal-chips--follow-the-path-of-least-impedance.html).
- Assign ground pours explicitly to the intended GND net; refill zones and verify continuity after routing changes.
- For congested boards, compare DRC-passing placement/routing variants; prefer fewer vias and shorter traces.

## Fabrication

- Generate fabrication and assembly files together from the same final PCB revision through the Makefile pipeline.
- Record each board’s material, thickness, layer stackup, copper weight, surface finish, mask/silkscreen colours, and assembly sides.
- Package each PCB separately with Gerbers for every copper layer, mask, silkscreen, outline, and required paste layers, plus Excellon PTH/NPTH drills. [JLCPCB export guide](https://jlcpcb.com/help/article/how-to-generate-gerber-and-drill-files-in-kicad-9).
- Use consistent millimetre coordinates and origins across Gerber, drill, and CPL exports.
- Export JLCPCB-compatible BOM and CPL files for the PCBA subset; require matching, unique designators and correct BOM quantities. [BOM/CPL guidance](https://jlcpcb.com/help/article/advice-for-bom-and-cpl-files-preparation).
- Verify CPL centroids, board sides, and rotations against the final layout; check pin 1 and polarity, including bottom-side components. [CPL format](https://jlcpcb.com/help/article/pick-place-file-for-pcb-assembly).
- Review exported Gerbers and drills in a Gerber viewer; check layer alignment, outlines, cutouts, holes/slots, solder mask, and silkscreen.
- Include assembly drawings and instructions covering polarity, hand-fitted/DNP parts, mounting hardware, stack assembly, and prototype bring-up, programming, and calibration.
- Package releases by board and hardware revision with manufacturing files, KiCad projects, schematic PDFs, STEP models, and assembly notes; record the source commit and tool versions.
- Hand off the fabrication package and manufacturing settings for user review and ordering; never place PCB or assembly orders yourself.

### JLCPCB requirements

- Select and record Economic or Standard PCBA before layout; verify current board-size, stackup, finish, colour, package, and assembly-side limits. [Assembly capabilities](https://jlcpcb.com/capabilities/pcb-assembly-capabilities).
- Reserve assembly handling features before placement: Economic PCBA requires 2–3 Ø1.152 mm NPTH tooling holes with 0.148 mm mask expansion; Standard PCBA requires edge rails and fiducials. [Tooling holes](https://jlcpcb.com/help/article/how-to-add-tooling-holes-for-pcb-assembly-order) · [Assembly capabilities](https://jlcpcb.com/capabilities/pcb-assembly-capabilities).
- Follow JLCPCB’s package-pair spacing recommendations and measurement method when placing SMD components. [Component spacing](https://jlcpcb.com/help/article/minimum-spacing-for-smd-components).
- Configure solder-mask expansion and dam limits for the selected layer count, copper weight, and mask colour. [Solder-mask guidance](https://jlcpcb.com/blog/basic-design-of-solder-mask).
- Check panel cutouts and board-stack fits against outline, hole, and thickness tolerances; allow ±10% thickness variation for nominal 1.6 mm FR-4. [PCB capabilities](https://jlcpcb.com/capabilities/pcb-capabilities/).
