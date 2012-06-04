SRCRPMURL  = http://vault.centos.org/6.2/os/Source/SPackages/tzdata-2011l-4.el6.src.rpm
RPMNAME    = $(shell basename $(SRCRPMURL))
RPMINSTALL = unp
RPMBUILD   = rpmbuild --define '_topdir '`pwd`


BUILDENV = \
					 BUILD		\
					 RPMS			\
					 SOURCES	\
					 SPECS		\
					 SRPMS

TZDATAPATCHES = \
								patches/australia-names.diff	\
								patches/tst-timezone.patch

SPECPATCH = \
						patches/tzdata.spec.patch


tzpackage.mk: environment.mk
		wget $(SRCRPMURL);
		touch $@;
		$(RPMINSTALL) $(RPMNAME);
		mv *.patch *.tar.* SOURCES;
		mv *.spec SPECS;
		cp $(TZDATAPATCHES) SOURCES;
		cat $(SPECPATCH) | patch -p0 -d SPECS;


environment.mk:
		for dir in $(BUILDENV); do \
				mkdir -p $$dir;\
		done;\
		touch $@;


all: %.mk
		$(RPMBUILD) -ba SPECS/tzdata.spec;
		echo "Done"

clean:
		rm -rf $(BUILDENV)
		rm -f $(RPMNAME)
		rm -f *.mk
