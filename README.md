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
