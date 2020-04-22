all: tarball
	
tarball:
	git archive --format=tar HEAD | gzip > jenkins-in-house-plugins-build-flow-plugin.tar.gz

clean:
	git fetch origin
	git reset --hard origin/SETI-4077-test
	rm -rf /root/rpmbuild/SOURCES/jenkins-in-house-plugins-build-flow-plugin.tar.gz jenkins-in-house-plugins-build-flow-plugin.tar.gz
	rm -rf /var/lib/juseppe/unz/*
	rm -rf /root/rpmbuild/SOURCES/jenkins-in-house-plugins-build-flow-plugin.tar.gz 
	yum remove -y jenkins-in-house-plugins-build-flow-plugin
	yum clean all

build:
	cp jenkins-in-house-plugins-build-flow-plugin.tar.gz /root/rpmbuild/SOURCES/jenkins-in-house-plugins-build-flow-plugin.tar.gz
	rpmbuild -ba build-flow-plugin.spec

check:
	createrepo -v /root/rpmbuild/RPMS/x86_64/
	yum install jenkins-in-house-plugins-build-flow-plugin
	mv /var/lib/juseppe/build-flow-plugin.hpi /var/lib/juseppe/unz/
	unzip /var/lib/juseppe/unz/build-flow-plugin.hpi -d /var/lib/juseppe/unz/
	cat /var/lib/juseppe/unz/META-INF/MANIFEST.MF

test:
	rpm2cpio /root/rpmbuild/RPMS/x86_64/jenkins-in-house-plugins-build-flow-plugin-2.0.9-1.el7.x86_64.rpm | cpio -idmv
	unzip var/lib/juseppe/stork-pi-pool.hpi -d var/lib/juseppe/unz/
	cat var/lib/juseppe/unz/META-INF/MANIFEST.MF

.PHONY: all tarball clean test build check
