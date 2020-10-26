################################################################################
#
# barrier
#
################################################################################

BARRIER_VERSION = 3395cca9673b645ddce3bac9141f148752f9494c
BARRIER_SITE = $(call github,debauchee,barrier,$(BARRIER_VERSION))
BARRIER_LICENSE = GPL-2.0
BARRIER_LICENSE_FILES = LICENSE
BARRIER_INSTALL_STAGING = YES

define BARRIER_BUILD_CMDS
  cd $(@D)
	git submodule update --init --recursive
	./clean_build.sh
	#$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)
endef

define BARRIER_INSTALL_TARGET_CMDS
endef
