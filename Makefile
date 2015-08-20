###############################################################################
################### MOOSE Application Standard Makefile #######################
###############################################################################
#
# Optional Environment variables
# MOOSE_DIR        - Root directory of the MOOSE project
#
###############################################################################
# Use the MOOSE submodule if it exists and MOOSE_DIR is not set
MOOSE_SUBMODULE    := $(CURDIR)/moose
ifneq ($(wildcard $(MOOSE_SUBMODULE)/framework/Makefile),)
  MOOSE_DIR        ?= $(MOOSE_SUBMODULE)
else
  MOOSE_DIR        ?= $(shell dirname `pwd`)/moose
endif

# framework
FRAMEWORK_DIR      := $(MOOSE_DIR)/framework
include $(FRAMEWORK_DIR)/build.mk
include $(FRAMEWORK_DIR)/moose.mk
## include $(MOOSE_DIR)/test/modules.mk
################################## MODULES ####################################
#-ALL_MODULES := yes
PHASE_FIELD       := yes
SOLID_MECHANICS   := yes
TENSOR_MECHANICS  := yes
HEAT_CONDUCTION   := yes
MISC              := yes
# COMBINED          := yes
include $(MOOSE_DIR)/modules/modules.mk
###############################################################################
# MARMOT (optional)
MARMOT_DIR          ?= $(CURDIR)/marmot
ifneq ($(wildcard $(MARMOT_DIR)/Makefile),)
  APPLICATION_DIR    := $(MARMOT_DIR)
  APPLICATION_NAME   := marmot
  include            $(FRAMEWORK_DIR)/app.mk
  ADDITIONAL_CPPFLAGS += -DMARMOT_ENABLED
endif

# dep apps
APPLICATION_DIR    := $(CURDIR)
APPLICATION_NAME   := Crow
BUILD_EXEC         := yes
DEP_APPS           := $(shell $(FRAMEWORK_DIR)/scripts/find_dep_apps.py $(APPLICATION_NAME))
include            $(FRAMEWORK_DIR)/app.mk

###############################################################################
# Additional special case targets should be added here
