WOKWI_PROJECT_ID=339800239192932947
# logic puzzle and muxes
# 4 inverters 334348818476696146
# the clock divider 334335179919196756
generate:
	ir_converter_main --top=popcount src/popcount.x > src/popcount.ir
	opt_main popcount.ir > src/popcount_opt.ir
	codegen_main --use_system_verilog=false --generator=combinational src/popcount_opt.ir > src/popcount.v

fetch:
	sed -i -e 's/USER_MODULE_ID/$(WOKWI_PROJECT_ID)/g' src/popcount.v
	sed -e 's/USER_MODULE_ID/$(WOKWI_PROJECT_ID)/g' template/scan_wrapper.v > src/scan_wrapper_$(WOKWI_PROJECT_ID).v
	sed -e 's/USER_MODULE_ID/$(WOKWI_PROJECT_ID)/g' template/config.tcl > src/config.tcl
	echo $(WOKWI_PROJECT_ID) > src/ID

# needs PDK_ROOT and OPENLANE_ROOT, OPENLANE_IMAGE_NAME set from your environment
harden:
	docker run --rm \
	-v $(OPENLANE_ROOT):/openlane \
	-v $(PDK_ROOT):$(PDK_ROOT) \
	-v $(CURDIR):/work \
	-e PDK_ROOT=$(PDK_ROOT) \
	-u $(shell id -u $(USER)):$(shell id -g $(USER)) \
	$(OPENLANE_IMAGE_NAME) \
	/bin/bash -c "./flow.tcl -overwrite -design /work/src -run_path /work/runs -tag wokwi"

