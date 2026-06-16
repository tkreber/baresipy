PYTHON ?= python3
PIP := $(PYTHON) -m pip
# --break-system-packages is required on PEP 668 ("externally-managed")
# interpreters such as Homebrew/Debian python; harmless elsewhere.
PIP_FLAGS := --user --break-system-packages

.PHONY: install dev uninstall clean

install:        ## install baresipy globally for the current user
	$(PIP) install $(PIP_FLAGS) --force-reinstall .

dev:            ## editable install (code changes take effect immediately)
	$(PIP) install $(PIP_FLAGS) -e .

uninstall:      ## remove baresipy (dependencies are kept)
	$(PIP) uninstall -y baresipy

clean:          ## remove build artifacts
	rm -rf dist build *.egg-info
