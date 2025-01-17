PACKAGES := $(wildcard packages/*)

print:
	for package in $(PACKAGES); do \
		echo $${package} ; \
	done

get:
	flutter pub get
	for package in $(PACKAGES); do \
		cd $${package} ; \
		echo "Updating dependencies on $${package}" ; \
		flutter pub get ; \
		cd ../../ ; \
	done