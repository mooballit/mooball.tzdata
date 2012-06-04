SRCRPMURL = http://vault.centos.org/6.2/os/Source/SPackages/tzdata-2011l-4.el6.src.rpm
RPMNAME = $(shell basename $(SRCRPMURL))
RPMINSTALL = unp

BUILDENV = \
					 BUILD		\
					 RPMS			\
					 SOURCES	\
					 SPECS		\
					 SRPMS


srcrpm: environment
		wget $(SRCRPMURL);
		$(RPMINSTALL) $(RPMNAME);
		mv *.patch *.tar.* SOURCES;
		mv *.spec SPECS;


environment:
		for dir in $(BUILDENV); do \
				mkdir -p $$dir;\
		done;\
		echo '%_topdir %(echo `%pwd`)' > .rpmmacros


all: environment srcrpm
		echo "Done"

clean:
		rm -rf $(BUILDENV)
		rm -f $(RPMNAME)
