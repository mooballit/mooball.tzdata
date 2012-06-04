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
								australia-names.diff	\
								tst-timezone.patch

SPECPATCH = \
						tzdata.spec.patch


srcrpm: environment
		wget $(SRCRPMURL);
		$(RPMINSTALL) $(RPMNAME);
		mv *.patch *.tar.* SOURCES;
		mv *.spec SPECS;
		cp $(TZDATAPATCHES) SOURCES;
		cat $(SPECPATCH) | patch -p0 -d SPECS;


environment:
		for dir in $(BUILDENV); do \
				mkdir -p $$dir;\
		done;\


all: environment srcrpm
		echo "Done"

clean:
		rm -rf $(BUILDENV)
		rm -f $(RPMNAME)
