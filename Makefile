# Copyright (c) 2012 Mooball IT
# See also LICENSE.txt
#
# Makefile to patch and create an RPM.
# Theory: Update the SRCRPMURL to a new tzdata or anything else in this
# package (e.g. the patches), push it to issue a rebuild of the tzdata
# package.
#
# This Makefile is only written for Debian. It may not work on any other
# OS.
SRCRPMURL  = http://vault.centos.org/6.4/updates/Source/SPackages/tzdata-2013g-1.el6.src.rpm
RPMNAME    = $(shell basename $(SRCRPMURL))
RPMINSTALL = unp
RPMBUILD   = rpmbuild --define '_topdir '`pwd` -ba $(BFLAGS)


BUILDENV = \
					 BUILD		\
					 RPMS			\
					 SOURCES	\
					 SPECS		\
					 SRPMS

TZDATAPATCHES = \
								patches/australia-names.diff

SPECPATCH = \
						patches/tzdata.spec.patch


all: SPECS/tzdata.spec RPMS/noarch/*.rpm
		echo "Done"

SOURCES/*.*: $(BUILDENV) $(RPMNAME)
		rpm2cpio $(RPMNAME) | cpio -idmv;
		mv *.patch *.tar.* SOURCES;
		mv *.spec SPECS;
		cp $(TZDATAPATCHES) SOURCES;

SPECS/tzdata.spec: SOURCES/*.*
		cat $(SPECPATCH) | patch -p0 -d SPECS;

$(RPMNAME):
		wget $(SRCRPMURL);

$(BUILDENV):
		mkdir -p $@;

RPMS/noarch/*.rpm:
		$(RPMBUILD) SPECS/tzdata.spec;


.PHONY: clean
clean:
		rm -rf $(BUILDENV)
		rm -f $(RPMNAME)
