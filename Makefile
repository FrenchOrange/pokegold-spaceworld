ROM := pokegold-spaceworld.gb
CORRECTEDROM := $(ROM:%.gb=%-correctheader.gb)
BASEROM := baserom.gb

DIRS := home engine data gfx audio maps scripts ram slack en
FILES :=

BUILD := build

rwildcard = $(foreach d, $(wildcard $1*), $(filter $(subst *, %, $2), $d) $(call rwildcard, $d/, $2))
ASMFILES := $(call rwildcard, $(DIRS), *.asm) $(FILES)
OBJS := $(patsubst %.asm, $(BUILD)/%.o, $(ASMFILES))
OBJS += $(BUILD)/shim.o


### Build tools

ifeq (,$(shell which sha1sum))
SHA1 := shasum
else
SHA1 := sha1sum
endif

PYTHON := python3

RGBDS ?=
RGBASM  ?= $(RGBDS)rgbasm
RGBFIX  ?= $(RGBDS)rgbfix
RGBGFX  ?= $(RGBDS)rgbgfx
RGBLINK ?= $(RGBDS)rgblink

RGBASMFLAGS := -h -E -i $(BUILD)/ -DGOLD

SCAN_INCLUDES := tools/scan_includes
MAKE_SHIM := tools/make_shim.py

tools/gfx :=


### Build targets

.SECONDEXPANSION:

.PHONY: all
all: $(ROM) $(CORRECTEDROM)

.PHONY: compare
compare: $(ROM) $(CORRECTEDROM)
	@$(SHA1) -c roms.sha1

.PHONY: tools
tools tools/pkmncompress tools/gfx tools/scan_includes:
	"$(MAKE)" -C tools/

# Remove files generated by the build process.
.PHONY: clean
clean:
	rm -rf $(ROM) $(CORRECTEDROM) $(ROMS:.gb=.sym) $(ROMS:.gb=.map) $(BUILD)
	"$(MAKE)" -C tools clean

# Remove generated files except for graphics.
.PHONY: tidy
tidy:
	rm -rf $(ROM) $(CORRECTEDROM) $(ROMS:.gb=.sym) $(ROMS:.gb=.map) $(OBJS) $(BUILD)/shim.asm

# Visualize disassembly progress.
.PHONY: coverage
coverage: $(ROM:.gb=.map)
	utils/coverage.py $<


### Build products

%.map: %.gb

$(CORRECTEDROM): %-correctheader.gb: %.gb
	cp $< $@
	cp $(<:.gb=.sym) $(@:.gb=.sym)
	$(RGBFIX) -f hg -m 0x10 $@

$(ROM): poke%-spaceworld.gb: layout.link $(OBJS) | $(BASEROM)
	$(RGBLINK) -d -n $(@:.gb=.sym) -m $(@:.gb=.map) -l layout.link -O $(BASEROM) -o $@ $(filter-out $<, $^)
	$(RGBFIX) -f lh -k 01 -l 0x33 -m 0x03 -p 0 -r 3 -t "POKEMON2$(shell echo $* | cut -d _ -f 1 | tr '[:lower:]' '[:upper:]')" $@

$(BASEROM):
	@echo "Please obtain a copy of Gold_debug.sgb and put it in this directory as $@"
	@exit 1

$(BUILD)/shim.asm: shim.sym | $$(dir $$@)
	$(MAKE_SHIM) $< > $@


### Misc file-specific graphics rules
include gfx/gfx.mk
include slack/slack.mk


### Catch-all build target rules

$(BUILD)/%.o: $(BUILD)/%.asm | $$(dir $$@)
	$(RGBASM) $(RGBASMFLAGS) $(OUTPUT_OPTION) $<

$(BUILD)/%.o: %.asm | $$(dir $$@)
	$(RGBASM) $(RGBASMFLAGS) $(OUTPUT_OPTION) $<

$(BUILD)/%.d: %.asm | $$(dir $$@) $(SCAN_INCLUDES)
	@$(SCAN_INCLUDES) -b $(BUILD)/ -i $(BUILD)/ -i ./ -o $@ -t $(@:.d=.o) $<

.PRECIOUS: $(BUILD)/%.pic
$(BUILD)/%.pic: $(BUILD)/%.2bpp tools/pkmncompress | $$(dir $$@)
	tools/pkmncompress $< $@

.PRECIOUS: $(BUILD)/%.2bpp
$(BUILD)/%.2bpp: %.png tools/gfx | $$(dir $$@)
	$(RGBGFX) $(OUTPUT_OPTION) $<
	tools/gfx $(tools/gfx) $(OUTPUT_OPTION) $@

.PRECIOUS: $(BUILD)/%.1bpp
$(BUILD)/%.1bpp: %.1bpp.png tools/gfx | $$(dir $$@)
	$(RGBGFX) -d1 $(OUTPUT_OPTION) $<
	tools/gfx $(tools/gfx) -d1 $(OUTPUT_OPTION) $@

.PRECIOUS: $(BUILD)/%.tilemap
$(BUILD)/%.tilemap: %.png | $$(dir $$@)
	$(RGBGFX) -t $@ $<

.PRECIOUS: %/
%/:
	mkdir -p $@


### Scan .asm files for INCLUDE dependencies

ifeq (,$(filter clean tools,$(MAKECMDGOALS)))
-include $(patsubst %.o, %.d, $(OBJS))
endif
