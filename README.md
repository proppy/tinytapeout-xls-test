![](../../workflows/wokwi/badge.svg)

# XLS template for TinyTapeout

Template for submitting [TinyTapeout](https://tinytapeout.com) designs based on [XLS: Accelerated HW Synthesis](https://github.com/google/xls) toolkit.

## Flow

### DSLX input

```
pub fn user_module(io_in: u8) -> u8 {
  io_in
<}

#![test]
fn user_module_test() {
  let _= assert_eq(user_module(u8:0b0010_1010), u8:42);
  _
}
```

### Verilog output

```
module user_module_USER_MODULE_ID(
  input wire [7:0] io_in,
  output wire [7:0] out
);
  assign out = io_in;
endmodule
```

### GDS Layout preview

![img](gds_render.svg)

### Examples

- [8-bit inverter](notebooks/inverter.ipynb)

<a href=\"https://colab.research.google.com/github/proppy/tinytapeout-xls-test/blob/main/notebooks/inverter.ipynb\" target=\"_parent\"><img src=\"https://colab.research.google.com/assets/colab-badge.svg\" alt=\"Open In Colab\"/></a>

- [8-bit population count](popcount/popcount.ipynb)

<a href=\"https://colab.research.google.com/github/proppy/tinytapeout-xls-test/blob/main/notebooks/popcount.ipynb\" target=\"_parent\"><img src=\"https://colab.research.google.com/assets/colab-badge.svg\" alt=\"Open In Colab\"/></a>

- [8-bit population count with bit twidding hacks](notebooks/popcount_bithacks.ipynb)

<a href=\"https://colab.research.google.com/github/proppy/tinytapeout-xls-test/blob/main/notebooks/popcount_bithacks.ipynb\" target=\"_parent\"><img src=\"https://colab.research.google.com/assets/colab-badge.svg\" alt=\"Open In Colab\"/></a>

# How to change the Wokwi project

Edit the [Makefile](Makefile) and change the WOKWI_PROJECT_ID to match your project.

# What is this about?

This repo is a template you can make a copy of for your own [ASIC](https://www.zerotoasiccourse.com/terminology/asic/) design using [Wokwi](https://wokwi.com/).

When you edit the Makefile to choose a different ID, the [GitHub Action](.github/workflows/wokwi.yaml) will fetch the digital netlist of your design from Wokwi.

The design gets wrapped in some extra logic that builds a 'scan chain'. This is a way to put lots of designs onto one chip and still have access to them all. You can see [all of the technical details here](https://github.com/mattvenn/scan_wrapper).

After that, the action uses the open source ASIC tool called [OpenLane](https://www.zerotoasiccourse.com/terminology/openlane/) to build the files needed to fabricate an ASIC.

# What files get made?

When the action is complete, you can [click here](https://github.com/mattvenn/wokwi-verilog-gds-test/actions) to see the latest build of your design. You need to download the zip file and take a look at the contents:

* gds_render.svg - picture of your ASIC design
* gds.html - zoomable picture of your ASIC design
* runs/wokwi/reports/final_summary_report.csv  - CSV file with lots of details about the design
* runs/wokwi/reports/synthesis/1-synthesis.stat.rpt.strategy4 - list of the [standard cells](https://www.zerotoasiccourse.com/terminology/standardcell/) used by your design
* runs/wokwi/results/final/gds/user_module.gds - the final [GDS](https://www.zerotoasiccourse.com/terminology/gds2/) file needed to make your design

# What next?

* Share your GDS on twitter, tag it #tinytapeout and [link me](https://twitter.com/matthewvenn)!
* [Submit it to be made](https://docs.google.com/forms/d/e/1FAIpQLSc3ZF0AHKD3LoZRSmKX5byl-0AzrSK8ADeh0DtkZQX0bbr16w/viewform?usp=sf_link)
* [Join the community](https://discord.gg/rPK2nSjxy8)
