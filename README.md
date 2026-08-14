# Multiple Regression Analysis of Cement Compressive Strength

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





# Çimento Sağlamlığı Üzerine Çoklu Regresyon Çözümlemesi

İST366 Regresyon Çözümlemesi dersi dönem ödevi. Çimento sağlamlığını etkileyen üretim
parametrelerinin R ile çoklu doğrusal regresyon analizi.

## Problem

Çimento sağlamlığının (MPa) su miktarı, kum sapması, karıştırma süresi ve çimento türüne
göre nasıl değiştiği modellenmiştir.

| Değişken | Açıklama | Tür |
|---|---|---|
| `y` | Çimento sağlamlığı (MPa) | Bağımlı, sürekli |
| `x1` | Su miktarı (L) | Bağımsız, sürekli |
| `x2` | İdeal kum miktarından sapma (kg) | Bağımsız, sürekli |
| `x3` | Karıştırma süresi (dk) | Bağımsız, sürekli |
| `x4` | Çimento türü (1 = Portland, 2 = Beyaz, 3 = Katkılı) | Bağımsız, kategorik |

## Yapılan Analizler

- Tanımlayıcı istatistikler
- Normallik incelemesi (Q-Q grafiği, Lilliefors K-S testi) ve logaritmik dönüşüm denemesi
- Doğrusallık incelemesi (saçılım matrisi)
- Artık incelemesi: Cook uzaklığı, kaldıraç (hat) değerleri, standartlaştırılmış ve student tipi artıklar
- Model anlamlılığı (F testi) ve katsayı anlamlılıkları (t testi)
- Belirtme katsayısı ve düzeltilmiş belirtme katsayısı
- Regresyon katsayıları için %99 güven aralıkları
- Değişen varyanslılık: artık grafiği ve Breusch-Pagan testi
- Özilişki: Durbin-Watson testi
- Çoklu bağlantı: VIF, tolerans, koşul sayısı, özdeğerler
- Uyum kestirimi ve ön kestirim (%95 güven ve öngörü aralıkları ile)
- Değişken seçimi: ileriye doğru, geriye doğru ve adımsal seçim
- Ridge regresyon ve ridge izi grafiği

## Bulgular

Aykırı ve etkin gözlemler çıkarıldıktan sonra kalan 196 gözlemle kurulan model:

```
ŷ = 10.63 + 10.28·x1 + 1.70·x2 − 2.38·x3 − 12.00·x4(Beyaz) − 11.96·x4(Katkılı)
```

- Model ve tüm katsayılar %95 güven düzeyinde anlamlı (p < 2.2e-16)
- Düzeltilmiş R² = 0.9997
- Değişen varyanslılık yok (BP testi, p = 0.4137)
- Özilişki yok (DW = 2.06, p = 0.6113)
- Çoklu bağlantı yok (tüm VIF < 3, en büyük koşul sayısı 22.01)
- İleriye doğru, geriye doğru ve adımsal seçim yöntemlerinin üçü de aynı sonuca ulaşarak
  tüm değişkenleri modelde tutmuştur

## Depo Yapısı

```
.
├── analiz.Rmd            # Tüm analiz kodu (R Markdown)
├── data/
│   ├── ham_veri.txt      # Ham veri seti (analizin girdisi)
│   └── son_veri.csv      # Artık incelemesi sonrası temizlenmiş veri (n = 196)
├── rapor.pdf             # Grafikler ve yorumlarla birlikte tam rapor
├── LICENSE
└── README.md
```

## Çalıştırma

R (≥ 4.0) ve RStudio gerekir. Gerekli paketler:

```r
install.packages(c("zoo", "nortest", "lmtest", "olsrr", "MASS"))
```

Depoyu klonladıktan sonra `analiz.Rmd` dosyasını RStudio'da açıp **Knit** butonuna basmanız
yeterlidir. Kod, veriyi `data/` klasöründen göreli yolla okur; çalışma dizininin depo kökü
olması gerekir.

## Veri Hakkında

Veri seti ders kapsamında öğrenciye özel olarak üretilmiş sentetik bir veridir; gerçek bir
çimento üretim sürecinden alınmamıştır. Değişken isimleri ve senaryo, regresyon
uygulamasını somutlaştırmak amacıyla tarafımdan atanmıştır.

## Not

Bu depo tamamlanmış bir ders ödevinin arşividir, öğrenme amaçlı paylaşılmıştır.
Aynı dersi alıyorsanız lütfen kendi verinizle kendi çözümünüzü üretin.

## Lisans

MIT — ayrıntılar için `LICENSE` dosyasına bakınız.
