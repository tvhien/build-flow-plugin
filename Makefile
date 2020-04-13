all: tarball
	
tarball:
	git archive --format=tar HEAD | gzip > jenkins-in-house-plugins-build-flow-plugin.tar.gz

.PHONY: all tarball
