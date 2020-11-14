################################################################################
#
# barrier
#
################################################################################

BARRIER_VERSION = b2cf133c5f0cb0d44eee8e9ecb1dff60cdedaf27
BARRIER_SITE = ssh://git@github.com/frbncis/barrier.git
BARRIER_SITE_METHOD = git
BARRIER_LICENSE = GPL-2.0
BARRIER_LICENSE_FILES = LICENSE
BARRIER_INSTALL_STAGING = YES
BARRIER_GIT_SUBMODULES = YES

BARRIER_CONF_OPTS =-DCMAKE_BUILD_TYPE=Release -DBARRIER_BUILD_GUI=OFF -DBARRIER_BUILD_TESTS=OFF -DBARRIER_BUILD_INSTALLER=OFF -DBARRIER_UNIX_HID_PLATFORM=ON

define BARRIER_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 -D $(BARRIER_PKGDIR)/S99barrierc \
		$(TARGET_DIR)/etc/init.d/S99barrierc
endef

$(eval $(cmake-package))
