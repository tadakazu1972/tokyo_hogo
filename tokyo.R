#ライブラリ読込
library(dplyr)
library(sf)
library(readr)
library(RColorBrewer)
library(classInt)

#作業ディレクトリ指定
setwd("~/Desktop/tokyo")

#必要なファイル読込
shape <- st_read("h27_did_13.shp")
hogo <- read_csv("xxxx.csv")

#結合後、23区のみ残す
data <- inner_join(shape, hogo, by="CITYNAME")

#地図描画
par(family="HiraKakuProN-W3")
col_km <- data$生活保護世帯 %>% classIntervals(., 10, style="fixed", fixedBreaks=c(min(.),2000,4000,6000,8000,10000,12000,14000,16000,18000,max(.))) %>% findColours(., c("white","orange","red"))
plot(shape[1:23,4], col=col_km, main="東京都23区　生活保護世帯数 平成29年9月")
text(st_coordinates(data %>% st_centroid)[,1], st_coordinates(data %>% st_centroid)[,2]+0.005, labels=data$CITYNAME, cex=1)
text(st_coordinates(data %>% st_centroid)[,1], st_coordinates(data %>% st_centroid)[,2]-0.005, labels=data$生活保護世帯, cex=1)

#################################

par(family="HiraKakuProN-W3")
col_km <- data$生活保護人員 %>% classIntervals(., 10, style="fixed", fixedBreaks=c(min(.),2000,4000,6000,8000,10000,12000,14000,16000,18000,max(.))) %>% findColours(., c("white","green","blue"))
plot(shape[1:23,4], col=col_km, main="東京都23区　生活保護人員数 平成29年9月")
text(st_coordinates(data %>% st_centroid)[,1], st_coordinates(data %>% st_centroid)[,2]+0.005, labels=data$CITYNAME, cex=1)
text(st_coordinates(data %>% st_centroid)[,1], st_coordinates(data %>% st_centroid)[,2]-0.005, labels=data$生活保護人員, cex=1)

#################################

par(family="HiraKakuProN-W3")
col_km <- data$保護率 %>% classIntervals(., 10, style="fixed", fixedBreaks=c(min(.),10,20,30,40,50,60,70,80,90,max(.))) %>% findColours(., c("yellow","orange","red"))
plot(shape[1:23,4], col=col_km, main="東京都23区　保護率(千分率) 平成29年9月")
text(st_coordinates(data %>% st_centroid)[,1], st_coordinates(data %>% st_centroid)[,2]+0.005, labels=data$CITYNAME, cex=1)
text(st_coordinates(data %>% st_centroid)[,1], st_coordinates(data %>% st_centroid)[,2]-0.005, labels=data$保護率, cex=1)