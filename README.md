# Multiple Regression Analysis of Cement Compressive Strength

*[Türkçe sürüm için: README.tr.md](README.tr.md)*

Term project for IST366 Regression Analysis. A complete multiple linear regression workflow
in R — from assumption checks and residual diagnostics through variable selection and ridge
regression.

## Problem

The analysis models how cement compressive strength (MPa) responds to production parameters:
water content, deviation from ideal sand quantity, mixing time, and cement type.

| Variable | Description | Type |
|---|---|---|
| `y` | Cement compressive strength (MPa) | Response, continuous |
| `x1` | Water content (L) | Predictor, continuous |
| `x2` | Deviation from ideal sand quantity (kg) | Predictor, continuous |
| `x3` | Mixing time (min) | Predictor, continuous |
| `x4` | Cement type (1 = Portland, 2 = White, 3 = Blended) | Predictor, categorical |

## Analyses Performed

- Descriptive statistics
- Normality assessment (Q-Q plots, Lilliefors K-S test) and a log-transformation attempt
- Linearity assessment via scatterplot matrix
- Residual diagnostics: Cook's distance, leverage (hat) values, standardized and studentized residuals
- Overall model significance (F test) and coefficient significance (t tests)
- Coefficient of determination and adjusted R²
- 99% confidence intervals for the regression coefficients
- Heteroscedasticity: residual plot and Breusch-Pagan test
- Autocorrelation: Durbin-Watson test
- Multicollinearity: VIF, tolerance, condition indices, eigenvalues
- Fitted-value and out-of-sample prediction with 95% confidence and prediction intervals
- Variable selection: forward, backward, and stepwise
- Ridge regression with ridge trace plot

## Results

After removing outlying and influential observations, the model fitted on the remaining
196 observations is:

```
ŷ = 10.63 + 10.28·x1 + 1.70·x2 − 2.38·x3 − 12.00·x4(White) − 11.96·x4(Blended)
```

- The model and every coefficient are significant at the 5% level (p < 2.2e-16)
- Adjusted R² = 0.9997
- No heteroscedasticity (Breusch-Pagan, p = 0.4137)
- No autocorrelation (Durbin-Watson = 2.06, p = 0.6113)
- No multicollinearity (all VIF < 3, largest condition index 22.01)
- Forward, backward, and stepwise selection all converge on the same model, retaining every predictor

The categorical predictor is dummy-coded with Portland cement as the reference level, so both
cement-type coefficients are read as differences relative to Portland.

## Repository Structure

```
.
├── analiz.Rmd            # Full analysis (R Markdown, Turkish)
├── analiz.R              # Same code as a plain R script
├── data/
│   ├── ham_veri.txt      # Raw data — input to the analysis
│   └── son_veri.csv      # Cleaned data after residual diagnostics (n = 196)
├── rapor.pdf             # Complete report with plots and interpretation (Turkish)
├── LICENSE
└── README.md
```

## Running the Analysis

Requires R (≥ 4.0) and RStudio. Install the dependencies:

```r
install.packages(c("zoo", "nortest", "lmtest", "olsrr", "MASS"))
```

Clone the repository, open `analiz.Rmd` in RStudio, and click **Knit**. Data is read via
relative paths from `data/`, so the working directory must be the repository root.

Note that the code, comments, and report are written in Turkish.

## About the Data

The dataset was synthetically generated for coursework and assigned individually to each
student; it does not come from a real cement production process. The variable names and the
scenario were chosen by me to give the regression exercise a concrete interpretation.

## Note

This repository archives a completed course assignment and is shared for learning purposes.
If you are taking the same course, please work through your own dataset and your own solution.

## License

MIT — see `LICENSE` for details.
