---
name: stat-dev
description: Statistical programming and package development in Stata, R, and Python. Use when writing, debugging, or reviewing Stata (.do/.ado/Mata), R (packages, scripts, ggplot2), or Python (pandas, numpy, data analysis) code. Also triggers for cross-language replication, econometric methods, or data pipeline tasks.
argument-hint: [language-or-task]
allowed-tools: Bash(R *), Bash(Rscript *), Bash(python *), Bash(python3 *), Bash(pytest *), Bash(pip *), Bash(pip3 *), Bash(git *), Bash(gh *), Bash(/Applications/Stata/*), Bash(/Applications/StataNow/*), Read, Grep, Glob, Edit, Write, Agent, WebSearch
---

# Statistical Programming & Package Development

ultrathink

Assist with statistical programming across Stata, R, and Python. Follow the conventions below based on the target language and task.

If $ARGUMENTS specifies a language or task, focus on that. Otherwise infer from context.

## Core Principles

1. **Cross-language replication**: When the same analysis exists in multiple languages, results must match to 6+ decimal places. Flag discrepancies immediately.
2. **Configuration-driven design**: Read parameters from config files (YAML/CSV/JSON), not hardcoded values.
3. **Documentation as first-class output**: Record every analysis decision in markdown alongside the code.
4. **Verification through visualization**: Generate plots to sanity-check numerical results. Trust pictures over numbers.
5. **Adversarial review**: Think like Referee 2 — actively look for errors, edge cases, unstated assumptions.

## Verification Strategy

Before delivering any statistical code:
- For R packages: run `devtools::check()` and report the result
- For Stata ado: run a minimal test `.do` file exercising the main command
- For Python: run `pytest` or a quick sanity-check script
- For cross-language: compare outputs side-by-side with tolerance-based assertions

When the task is complex, use a **subagent** (Explore, background) to investigate existing patterns in the codebase before writing new code. This keeps exploration out of the main context.

## R: Package Development

When working on R packages (DESCRIPTION, NAMESPACE, R/, man/, tests/):

### Structure & Workflow
- Use `devtools` workflow: `load_all()`, `document()`, `check()`, `test()`
- Documentation via `roxygen2` — use `@inheritParams` for shared parameters
- Tests via `testthat` — place in `tests/testthat/`
- Maintain strict ASCII collation order in DESCRIPTION Collate field
- Export selectively — not every function needs `@export`

### Code Conventions
- Pipe style: prefer base R `|>` for new code unless the package already uses `%>%`
- ggplot2 extensions: build on `ggplot2::ggproto`, use `ggpar()` for post-processing theming
- Data manipulation: `dplyr`/`tidyr` for interactive, base R for package internals when fewer deps matter
- Statistical layers: `rstatix` for pipe-friendly stats, `emmeans` for marginal means
- Plot arrangement: `cowplot::plot_grid()` or `patchwork`

### Common Pitfalls
- Check `R CMD check` with `--as-cran` before any release
- Watch for non-standard evaluation (NSE) — use `.data$col` or `{{ var }}` in tidy eval
- Factor levels: always verify ordering, never assume alphabetical
- Missing data: explicit `na.rm = TRUE` or document why NAs are excluded

## R: Statistical Analysis

- Linear models: `lm()`, `glm()`, `lme4::lmer()` / `lme4::glmer()`
- Robust SEs: `sandwich` + `lmtest`, or `estimatr::lm_robust()`
- Multivariate: `FactoMineR` for PCA/CA/MCA, `factoextra` for visualization
- Survival: `survival::coxph()`, `survminer` for plots
- Panel data: `plm` package
- Always report: point estimates, SEs/CIs, sample size, and model diagnostics

## Stata: Ado & Mata Development

When working on Stata programs (.ado/.do files, Mata code):

### Structure
- Main entry: `.ado` file with `program define` syntax
- Mata code: separate `.mata` or inline `mata:` blocks
- Help files: `.sthlp` with Stata's SMCL markup
- Use `syntax` command for argument parsing — leverage `varlist`, `if`, `in`, `options`

### Code Conventions
- Modular Mata: separate functions for numerical computation, keep ado as orchestrator
- Dynamic dependency checking: verify required packages (`ftools`, `reghdfe`, `ppmlhdfe`) at runtime with `capture which`
- Tempvars/tempnames: always use `tempvar` and `tempname` to avoid namespace pollution
- Preserve/restore: wrap destructive data operations in `preserve` / `restore`
- Return results: use `ereturn` for estimation commands, `return` for r-class

### High-Dimensional Fixed Effects
- `reghdfe` for OLS, `ppmlhdfe` for Poisson PML
- Stata 19+: native `hdfe` option available
- `ftools` required as dependency for fast factor operations
- Carefully document convergence criteria and iteration limits

### Common Pitfalls
- String vs numeric: Stata silently coerces — always check `describe` output
- Merge diagnostics: always check `_merge` variable, never drop unmatched silently
- Precision: Stata uses `double` by default but be explicit with `generate double`
- Mata memory: `st_view()` vs `st_data()` — views are more memory-efficient
- Version control: start ado files with `*! version X.Y.Z date` header

## Python: Data Analysis & Scripting

When working on Python data pipelines or analysis scripts:

### Stack
- DataFrames: `pandas` (or `polars` for performance)
- Numerics: `numpy`, `scipy`
- Stats: `statsmodels` for econometrics, `scipy.stats` for tests
- Visualization: `matplotlib`, `seaborn`
- Documents: `python-docx` for Word, `lxml` for XML/OMML manipulation

### Code Conventions
- Type hints for function signatures
- `pathlib.Path` over `os.path`
- Configuration via YAML/JSON files, not hardcoded params
- Logging via `logging` module, not print statements (for production scripts)
- Virtual environments: prefer `uv` for dependency management

### Common Pitfalls
- `pandas` copy vs view: use `.copy()` explicitly to avoid SettingWithCopyWarning
- Float comparison: use `np.isclose()` or `pd.testing.assert_frame_equal()` with tolerances
- Index alignment: `pandas` auto-aligns on index — be explicit with `.values` or `.reset_index()`
- Datetime parsing: always specify `format=` in `pd.to_datetime()`
- Memory: for large datasets, specify `dtype` upfront and use chunked reading

## Cross-Language Tasks

When replicating analysis across R/Stata/Python:

1. **Agree on the reference implementation** — which language is "ground truth"?
2. **Match data ingestion exactly** — same file, same filters, same variable types
3. **Compare intermediate results** — not just final output, check each transformation step
4. **Document precision target** — typically 6 decimal places for coefficient estimates
5. **Use tolerance-based comparison** — `all.equal()` in R, `assert` with tolerance in Python, `reldif()` in Stata
6. **Report any discrepancy** with exact values, step where divergence occurs, and likely cause

For complex cross-language work, launch **parallel subagents** — one per language — to implement independently, then compare results in the main context (fan-out/fan-in pattern).

## Output Standards

For any statistical output, always include:
- **Sample size** (N) and any exclusions with reasons
- **Point estimates** with standard errors or confidence intervals
- **Model specification** (variables, fixed effects, clustering)
- **Diagnostic checks** relevant to the method (e.g., overidentification, first-stage F for IV)
- **Reproducibility info** (software version, seed if randomization involved)
