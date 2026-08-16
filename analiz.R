# ==============================================================================
# IST366 Regresyon Cozumlemesi - Donem Odevi
# Cimento Saglamligi Uzerine Coklu Regresyon Analizi
# Miray Inci Basaran
#
# Bu betik analiz.Rmd dosyasindaki tum R kodlarinin duz betik halidir.
# Yorumlar ve grafik aciklamalari icin rapor.pdf dosyasina bakiniz.
# ==============================================================================

# Gerekli paketler:
# install.packages(c("zoo", "nortest", "lmtest", "olsrr", "MASS"))

# Veri goreli yolla okunur; calisma dizini depo koku olmalidir. getwd()


# ==============================================================================
# 1 - Senaryo
# ==============================================================================


# ------------------------------------------------------------------------------
# Kullanılan Kütüphaneler
# ------------------------------------------------------------------------------

library(zoo)
library(nortest)
library(graphics)
library(lmtest)
library(olsrr)
library(MASS)


# ==============================================================================
# 2 - Tanımlayıcı İstatistikler
# ==============================================================================

data<-read.table("data/ham_veri.txt", 
                   header = TRUE)
names(data)<-c("y","x1","x2","x3","x4")
names(data)
attach(data)

summary(data)


# ==============================================================================
# 3 - Normallik İncelemesi ve Doğrusallık
# ==============================================================================


# ------------------------------------------------------------------------------
# Normallik Testi
# ------------------------------------------------------------------------------

#Normallik
qqnorm(y)
qqline(y)
lillie.test(y)

boxplot(y)

lny<-log(y)
qqnorm(lny)
qqline(lny)
lillie.test(lny)

boxplot(lny)

#Sağlamlığı 70'den küçük olanları tut.
data_temiz <- subset(data, y < 70)
data_temiz
try(detach(data), silent = TRUE)
attach(data_temiz)

#Temiz veri üzerinden normallik testi
qqnorm(y)
qqline(y)
lillie.test(y)


# ------------------------------------------------------------------------------
# Doğrusallık İncelemesi
# ------------------------------------------------------------------------------

#Doğrusallık
pairs(data_temiz)


# ------------------------------------------------------------------------------
# Doğrusal Model
# ------------------------------------------------------------------------------

#Doğrusal model
sonuc<-lm(y~x1+x2+x3+factor(x4))
summary(sonuc)


# ==============================================================================
# 4 - Artık İncelemesi
# ==============================================================================

#Artık İncelemesi

#standart -> [-2:2]
#student -> [-2:2]
#cook -> 4/n = 4/220 = 0.0182
#hat -> 2*k/n = 2*6/220 = 0.0545

inf<-ls.diag(sonuc)
inf

#Cook içi grafik
plot(inf$cooks, type = "p", pch = 8, 
     main = "Influential Obs by Cooks distance", 
     xlab = "Index", ylab = "cooksd")
abline(h = 4/length(y), col = "red")
cooks_out <- which(inf$cooks > 4/length(y))
text(cooks_out, inf$cooks[cooks_out], labels = cooks_out, pos = 4, col = "red", cex = 0.8)

#Hat için grafik
plot(inf$hat, type = "p", pch = 8, 
     main = "Leverage Value by Hat value", 
     xlab = "Index", ylab = "hat")
k <- length(sonuc$coefficients)
abline(h = 2*k/length(y), col = "red")
hat_out <- which(inf$hat > 2*k/length(y))
text(hat_out, inf$hat[hat_out], labels = hat_out, pos = 4, col = "red", cex = 0.8)

#Standart için grafik

plot(inf$std.res, type = "p", pch = 8, 
     main = "Outlier by Standardized residuals", 
     xlab = "Index", ylab = "Standardized Residuals")
abline(h = c(-2, 2), col = "red")
std_out <- which(abs(inf$std.res) > 2)
text(std_out, inf$std.res[std_out], labels = std_out, pos = 4, col = "red", cex = 0.8)

#Studentized için grafik
plot(inf$stud.res, type = "p", pch = 8, 
     main = "Outlier by Studentized residuals", 
     xlab = "Index", ylab = "Studentized Residuals")
abline(h = c(-2, 2), col = "red")
stud_out <- which(abs(inf$stud.res) > 2)
text(stud_out, inf$stud.res[stud_out], labels = stud_out, pos = 4, col = "red", cex = 0.8)

#Artıkları temizlemek
k<-length(sonuc$coefficients)

son_veri<-data_temiz[inf$cooks < (4/length(y)) & 
                         inf$hat < (2*k/length(y)) & 
                         abs(inf$stud.res) < 2 &
                         abs(inf$std.res) < 2, ]
son_veri
nrow(son_veri)


# ==============================================================================
# 5 - Son Veri Üzerinden Analizler
# ==============================================================================


# ------------------------------------------------------------------------------
# Son Veri Normallik Testi
# ------------------------------------------------------------------------------

#Normallik
qqnorm(y)
qqline(y)
lillie.test(y)

boxplot(y)


# ------------------------------------------------------------------------------
# Son Veri Doğrusallık İncelemesi
# ------------------------------------------------------------------------------

#Doğrusallık
pairs(son_veri)


# ------------------------------------------------------------------------------
# Son Veri İçin Artık İncelemesi
# ------------------------------------------------------------------------------

#Yeni model
try(detach(data_temiz), silent = TRUE)
attach(son_veri)

son_model<-lm(y~x1+x2+x3+factor(x4), data = son_veri)

#Son model için tanımlar.
inf_son <- ls.diag(son_model)

p_son <- length(son_model$coefficients)

summary(son_model)

#Cook içi grafik
plot(inf_son$cooks, type = "p", pch = 8, 
     main = "Final: Influential Obs by Cooks distance", 
     xlab = "Index", ylab = "cooksd")
abline(h = 4/length(y), col = "red")

cooks_out <- which(inf_son$cooks > 4/length(y))
if(length(cooks_out) > 0) text(cooks_out, inf_son$cooks[cooks_out], labels = cooks_out, pos = 4, col = "red", cex = 0.8)

#Hat için grafik
plot(inf_son$hat, type = "p", pch = 8, 
     main = "Final: Leverage Value by Hat value", 
     xlab = "Index", ylab = "hat")
abline(h = 2*p_son/length(y), col = "red")

hat_out <- which(inf_son$hat > 2*p_son/length(y))
if(length(hat_out) > 0) text(hat_out, inf_son$hat[hat_out], labels = hat_out, pos = 4, col = "red", cex = 0.8)

#Standart için grafik
plot(inf_son$std.res, type = "p", pch = 8, 
     main = "Final: Outlier by Standardized residuals", 
     xlab = "Index", ylab = "Standardized Residuals")
abline(h = c(-2, 2), col = "red")

std_out <- which(abs(inf_son$std.res) > 2)
if(length(std_out) > 0) {
  text(std_out, inf_son$std.res[std_out], labels = std_out, pos = 4, col = "red", cex = 0.8)}

#Studentized için grafik
plot(inf_son$stud.res, type = "p", pch = 8, 
     main = "Final: Outlier by Studentized residuals", 
     xlab = "Index", ylab = "Studentized Residuals")
abline(h = c(-2, 2), col = "red")

stud_out <- which(abs(inf_son$stud.res) > 2)
if(length(stud_out) > 0) {
  text(stud_out, inf_son$stud.res[stud_out], labels = stud_out, pos = 4, col = "red", cex = 0.8)
}


# ------------------------------------------------------------------------------
# Son Veri Kestirim Denklemi
# ------------------------------------------------------------------------------

summary(son_model)


# ==============================================================================
# 6 - Katsayilarin Anlamliliklari  /  7 - Belirtme Katsayisi
# ==============================================================================
# Bu iki bolum yalnizca yorumdan olusur; ilgili sayisal ciktilar yukaridaki
# summary(son_model) sonucundan okunur. Yorumlar icin rapor.pdf'e bakiniz.

# ==============================================================================
# 8 - Güven Aralıkları
# ==============================================================================

confint(son_model, level = .99)


# ==============================================================================
# 9 - Değişen Varyanslılık Sorunu
# ==============================================================================

# Grafik için alanı hazırla
par(mfrow=c(1,1))

# Tahmin edilen değerler vs. Studentized Artıklar
plot(predict(son_model), rstudent(son_model), 
     main="Değişen Varyanslılık Kontrolü",
     xlab="Tahmin Edilen Değerler", 
     ylab="Studentized Artıklar")
abline(h=0, col="red")

# Breusch-Pagan Testi
bptest(son_model)


# ==============================================================================
# 10 - Özilişki Sorunu İncelemesi
# ==============================================================================

dwtest(son_model)


# ==============================================================================
# 11 - Çoklu Bağlantı Sorunu İncelemesi
# ==============================================================================

ols_coll_diag(son_model)

ozdeger = 1/4.711045365 + 1/1.000155491 + 1/0.229734910 + 1/0.032030783 + 1/0.017307375 + 1/0.009726076
ozdeger

# Yeni ve güncel model
son_model_v2 <- lm(y ~ x1 + x3 + factor(x4), data = son_veri)

summary(son_model_v2)


# ==============================================================================
# 12 - Uyum Kestirimi
# ==============================================================================

uyum_kestirimi <- son_veri[41, ]

uyum_kestirimi_deger <- predict(son_model_v2, newdata = uyum_kestirimi)

uyum_kestirimi_deger


# ==============================================================================
# 13 - Ön Kestirim
# ==============================================================================

on_kestirim <- data.frame(
  x1 = 8.2,
  x3 = 7.5,
  x4 = factor(1, levels = c(1, 2, 3))
)

predict(son_model_v2, newdata = on_kestirim)


# ==============================================================================
# 14 - Uyum Kestirimi ve Ön Kestirime Ait Güven Aralıkları
# ==============================================================================

uyum_kestirimi_ga <- son_veri[41, ]
guven_araligi <- predict(son_model_v2, newdata = uyum_kestirimi_ga, interval = "confidence", level = 0.95)
print(guven_araligi)

on_kestirim_ga <- data.frame(
  x1 = 8.2,
  x3 = 7.5,
  x4 = factor(1, levels = c(1, 2, 3))
)
ongoru_araligi <- predict(son_model_v2, newdata = on_kestirim_ga, interval = "prediction", level = 0.95)
print(ongoru_araligi)


# ==============================================================================
# 15 - Değişken Seçimi ile Model Kurma
# ==============================================================================

lm.null <- lm(y ~ 1)

forward <- step(lm.null, y ~ x1 + x2 + x3 + factor(x4), direction = "forward")

forward

summary(forward)

full_model <- lm(y ~ x1 + x2 + x3 + factor(x4), data = son_veri)

backward <- step(full_model, direction = "backward")

summary(backward)

step.model <- stepAIC(full_model, direction = "both" , trace="FALSE")
summary(step.model)


# ==============================================================================
# 16 - Ridge Regresyon
# ==============================================================================

ridge <- lm.ridge(y ~ x1 + x2 + x3 + factor(x4), data = son_veri, lambda = seq(0, 1000, 50))
matplot(ridge$lambda, t(ridge$coef), type = "l", 
        xlab = expression(lambda), 
        ylab = expression(hat(beta)))
abline(h=0,lwd=2)
ridge$coef

ridge$coef[, ridge$lam == 100]

write.csv(son_veri, "data/son_veri.csv", row.names = TRUE)
