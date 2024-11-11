SHELL=/bin/bash

install: 
		unset CONDA_PREFIX && \
		source .venv/bin/activate && maturin develop

install-release:
		unset CONDA_PREFIX && \
		source .venv/bin/activate && maturin develop --release

pre-commit:
	cargo +nightly fmt --all && cargo clippy --all-features
	.venv/bin/python -m ruff check . --fix --exit-non-zero-on-fix
	.venv/bin/python -m ruff format polars_mcu_toolkit tests
	.venv/bin/mypy polars_mcu_toolkit tests

test:
	.venv/bin/python -m pytest tests

run: install
	source .venv/bin/activate && python run.py

run-release: install-release
	source .venv/bin/activate && python run.py