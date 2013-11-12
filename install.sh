# install the .rpm
rpm -Uvh --replacepkgs --replacefiles RPMS/noarch/tzdata-2013g-1.el6.noarch.rpm
# replace the localtime file with the new time file for Queensland (because that's where we are)
# NOTE: some distros may have /etc/localtime symlinked to the appropriate time file
cp /usr/share/zoneinfo/Australia/Queensland /etc/localtime
