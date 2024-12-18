# command aliases
PYTHON = python3

# location aliases
PROJECT_NAME = titanic
SRC_DIR = $(PROJECT_NAME)
DOC_DIR = doc
IPYNB_DIR = ipynb
LOG_DIR = log
OUT_DIR = out
RES_DIR = res
TST_DIR = test

# phony targets
.PHONY: all                                                              \
		conda-create conda-activate conda-deactivate 					 \
		clean-all clean-resources clean-logs clean-output clean-runfiles \
		format format-source format-notebook                             \
		check check-test                                                 \
		test test-verbose                                                \
		start-notebook list-notebook stop-notebook                       \
		open-links                                                       \
		help

# targets
all: format check check-test test

conda-create:
	@echo "Creating conda environement..."
	conda create               \
		--prefix=$(pwd)/.conda \
		python=3.12            \
		autoflake              \
		conda-forge::git-cliff \
		conda-forge::polars    \
		git-cliff              \
		ipykernel              \
		isort                  \
		kaggle                 \
		mypy                   \
		nbstripout			   \
		numpy                  \
		pandas black           \
		pytest                 \
		python-dotenv          \
		pytorch                \
		scikit-learn           \
		seaborn                \
		xgboost

conda-activate:
	@echo "Activating conda environment..."
	conda activate $(pwd)/.conda

conda-deactivate:
	@echo "Deactivating conda environment..."
	conda deactivate

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

format: format-source format-notebook

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

open-links:
	@echo "Opening links..."
	brave --new-window                   \
		--new-tab numpy.org              \
		--new-tab pola.rs                \
		--new-tab scikit-learn.org       \
		--new-tab seaborn.pydata.org     \
		--new-tab xgboost.readthedocs.io \
		--new-tab pytorch.org

help:
	@echo "Usage: make [target]"
	@echo "Targets:"
	@echo "  all:              Format, check, and test the project"
	@echo "  conda-create:     Setup conda environment"
	@echo "  conda-activate:   Activate poetry shell"
	@echo "  conda-deactivate: Deactivate the existing poetry shell"
	@echo "  clean-all:        Clean all generated files"
	@echo "  clean-resources:  Clean resource files"
	@echo "  clean-logs:       Clean log files"
	@echo "  clean-output:     Clean output files"
	@echo "  clean-runfiles:   Clean run files"
	@echo "  format:           Format the project"
	@echo "  check:            Check implementation"
	@echo "  check-tests:      Check tests"
	@echo "  test:             Test the project"
	@echo "  test-verbose:     Test the project with verbose output"
	@echo "  changelog:        Update the changelog"
	@echo "  start-notebook:   Start Jupyter Notebook"
	@echo "  list-notebook:    List Jupyter Notebook"
	@echo "  stop-notebook:    Stop Jupyter Notebook"
	@echo "  help:             Show this help message"
