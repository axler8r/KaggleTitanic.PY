# command aliases
PYTHON = python3

# location aliases
PROJECT_NAME = titanic
SRC_DIR = $(PROJECT_NAME)
DOC_DIR = documentation
IPYNB_DIR = notebook
LOG_DIR = log
OUT_DIR = output
RES_DIR = resource
TST_DIR = test

# phony targets
.PHONY: all                                                              \
		activate deactivate reactivate                                   \
		clean-all clean-resources clean-logs clean-output clean-runfiles \
		check check-test                                                 \
		test test-verbose                                                \
		start-notebook list-notebook stop-notebook                       \
		help

# targets
all: format check test

init: activate
	@echo "Initializing $(PROJECT_NAME)..."
	mkdir doc log out res
	poetry install

activate:
	@echo "Activating poetry shell..."
	poetry shell

reactivate:
	@echo "Reactivating existing poetry shell..."
	bash -c "source $(shell poetry env info --path)/bin/activate"

deactivate:
	@echo "Deactivating existing poetry shell..."
	deactivate

clean-runfiles:
	rm -rf **/__pycache__
	rm -rf **/.ipynb_checkpoints

clean-output:
	rm -f $(OUT_DIR)/*

clean-logs:
	rm -f $(LOG_DIR)/*

clean-resources:
	rm -f $(RES_DIR)/*

clean-all: clean-runfiles clean-output clean-logs clean-resources

format-source:
	@echo "Formatting $(PROJECT_NAME)..."
	$(PYTHON) -m autoflake          \
		--remove-all-unused-imports \
		--remove-unused-variables   \
		--in-place                  \
		--recursive $(SRC_DIR) $(TST_DIR)
	$(PYTHON) -m isort $(SRC_DIR) $(TST_DIR)
	$(PYTHON) -m black $(SRC_DIR) $(TST_DIR)

format-notebook:
	@echo "Formatting $(PROJECT_NAME)..."
	$(PYTHON) -m autoflake          \
		--remove-all-unused-imports \
		--remove-unused-variables   \
		--in-place                  \
		--recursive $(IPYNB_DIR)
	$(PYTHON) -m isort $(IPYNB_DIR)
	$(PYTHON) -m black --line-length=120 $(IPYNB_DIR)

check:
	@echo "Checking $(PROJECT_NAME)..."
	$(PYTHON) -m mypy            \
		--check-untyped-defs     \
		--ignore-missing-imports \
		$(SRC_DIR)

check-test:
	@echo "Checking $(PROJECT_NAME)..."
	$(PYTHON) -m mypy $(TST_DIR)

test:
	@echo "Testing $(TST_DIR)..."
	$(PYTHON) -m pytest $(TST_DIR)

test-verbose:
	@echo "Testing $(TST_DIR)..."
	$(PYTHON) -m pytest --verbose $(TST_DIR)

changelog:
	@echo "Releasing $(PROJECT_NAME)..."
	git cliff --bump

start-notebook:
	@echo "Starting Jupyter Notebook..."
	nohup jupyter lab --no-browser --port 18080 > output/jupyter-lab.out &

list-notebook:
	@echo "Listing Jupyter Notebook..."
	jupyter notebook list

stop-notebook:
	@echo "Stopping Jupyter Notebook..."
	jupyter notebook stop 18080

help:
	@echo "Usage: make [target]"
	@echo "Targets:"
	@echo "  all:             Format, check, and test the project"
	@echo "  init:            Initialize the project"
	@echo "  activate:        Activate poetry shell"
	@echo "  reactivate:      Reactivate the existing poetry shell"
	@echo "  deactivate:      Deactivate the existing poetry shell"
	@echo "  clean-all:       Clean all generated files"
	@echo "  clean-resources: Clean resource files"
	@echo "  clean-logs:      Clean log files"
	@echo "  clean-output:    Clean output files"
	@echo "  clean-runfiles:  Clean run files"
	@echo "  format:          Format the project"
	@echo "  check:           Check implementation"
	@echo "  check-tests:     Check tests"
	@echo "  test:            Test the project"
	@echo "  test-verbose:    Test the project with verbose output"
	@echo "  changelog:       Update the changelog"
	@echo "  start-notebook:  Start Jupyter Notebook"
	@echo "  list-notebook:   List Jupyter Notebook"
	@echo "  stop-notebook:   Stop Jupyter Notebook"
	@echo "  help:            Show this help message"
