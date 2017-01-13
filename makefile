SOLR_VERSION := 6.3.0
SOLR_TARBALL := solr-$(SOLR_VERSION).tgz

image: build/Dockerfile build/$(SOLR_TARBALL)
	docker build -t solr build 

build:
	mkdir -p build

build/Dockerfile: Dockerfile.in build
	sed -e 's/{{SOLR_TARBALL}}/$(SOLR_TARBALL)/g' \
		-e 's/{{SOLR_VERSION}}/$(SOLR_VERSION)/g' \
		Dockerfile.in > $@

build/$(SOLR_TARBALL):
	wget -qO $@ http://archive.apache.org/dist/lucene/solr/$(SOLR_VERSION)/$(SOLR_TARBALL)
