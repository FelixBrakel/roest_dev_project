BUILDS = release debug
BUILD_DIR = out
TOOL_DIR = tools
RELEASE_FRAG_SHADERS = $(addprefix $(BUILD_DIR)/release/, $(wildcard resources/shaders/*.frag))
RELEASE_VERT_SHADERS = $(addprefix $(BUILD_DIR)/release/, $(wildcard resources/shaders/*.vert))

DEBUG_FRAG_SHADERS = $(addprefix $(BUILD_DIR)/debug/, $(wildcard resources/shaders/*.frag))
DEBUG_VERT_SHADERS = $(addprefix $(BUILD_DIR)/debug/, $(wildcard resources/shaders/*.vert))

.PRECIOUS: $(BUILD_DIR)/ $(BUILD_DIR)%/

RELEASE_TARGETS = $(BUILD_DIR)/release/roest_runtime
DEBUG_TARGETS = $(BUILD_DIR)/debug/roest_runtime

TOOL_TARGETS = $(TOOL_DIR)/mesh_importer

all: debug release tools

release: $(RELEASE_TARGETS) $(RELEASE_FRAG_SHADERS) $(RELEASE_VERT_SHADERS)

debug: $(DEBUG_TARGETS) $(DEBUG_FRAG_SHADERS) $(DEBUG_VERT_SHADERS)

tools: $(TOOL_TARGETS)

$(BUILD_DIR)/ $(TOOL_DIR)/:
	mkdir -p $@

$(BUILD_DIR)%/ $(TOOL_DIR)%/:
	mkdir -p $@

roest/target/debug/%:
	cd roest; cargo build --package $* --bin $*

roest/target/release/%:
	cd roest; cargo build --release --package $* --bin $*

.SECONDEXPANSION:

$(TOOL_DIR)/mesh_importer: roest/target/release/mesh_importer | $$(@D)/
	cp $< $@

$(BUILD_DIR)/debug/resources/shaders/%.frag: resources/shaders/%.frag | $$(@D)/
	cp $< $@

$(BUILD_DIR)/release/resources/shaders/%.frag: resources/shaders/%.frag | $$(@D)/
	cp $< $@

$(BUILD_DIR)/debug/resources/shaders/%.vert: resources/shaders/%.vert | $$(@D)/
	cp $< $@

$(BUILD_DIR)/release/resources/shaders/%.vert: resources/shaders/%.vert | $$(@D)/
	cp $< $@

$(addprefix $(BUILD_DIR)/, $(addsuffix /roest_runtime, $(BUILDS))): $(BUILD_DIR)/%/roest_runtime: roest/target/%/roest_runtime | $$(@D)/
	cp roest/target/$*/roest_runtime $(BUILD_DIR)/$*/

clean:
	rm -rf $(BUILD_DIR)/

$(addprefix clean-, $(BUILDS)): clean-%:
	rm -rf $(BUILD_DIR)/$*

