################################################################################
#
# barrier
#
################################################################################

BARRIER_VERSION = 3395cca9673b645ddce3bac9141f148752f9494c
BARRIER_SITE = git://github.com/debauchee/barrier.git
BARRIER_SITE_METHOD = git
BARRIER_LICENSE = GPL-2.0
BARRIER_LICENSE_FILES = LICENSE
BARRIER_INSTALL_STAGING = YES
BARRIER_GIT_SUBMODULES = YES

BARRIER_CONF_OPTS =-DCMAKE_BUILD_TYPE=Release

$(eval $(cmake-package))
