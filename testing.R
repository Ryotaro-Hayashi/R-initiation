install.packages("coin", dependencies = TRUE)
library(coin)
# データを読み込む
ex11_correct <- read.csv("/Users/ryotarohayashi/Desktop/R-statistics/ex1-1_correct.csv", header=TRUE, skip=0, stringsAsFactors = T)$seconds
ex11_incorrect <- read.csv("/Users/ryotarohayashi/Desktop/R-statistics/ex1-1_incorrect.csv", header=TRUE, skip=0, stringsAsFactors = T)$seconds
# 操作時間で検定
f1 <- shapiro.test(ex11_correct)

# 正規分布しているかどうかを判断するためにp値を求める
f1$p.value
f2 <- shapiro.test(ex11_incorrect)
f2$p.value
ff <- var.test(ex11_correct, ex11_incorrect, conf.level=0.95)
ff$p.value

# 正規分布の場合
if (0.05 <= f1$p && 0.05 <= f2$p) {
  # F検定で等分散か調べる(有意水準5%でp<0.05なら等分散)
  if (var.test(ex11_correct, ex11_incorrect, conf.level=0.95)$p.value < 0.05) {
    # 等分散のとき， スチューデントのt検定5%で検定
    t.test(ex11_correct, ex11_incorrect, var.equal=T, paired=F)
  } else {
    # 不等分散のとき， ウェルチのt検定5%で検定
    t.test(ex11_correct, ex11_incorrect, var.equal=F) # 両側
  }
# 正規分布ではない場合
} else {
  # ウィルコクソンの順位和検定
  wilcox_test(c(ex11_correct,ex11_incorrect) 
              ~ factor(c(rep("ex11_correct",length(ex11_correct)),
                         rep("ex11_incorrect",length(ex11_incorrect)))),
              distribution="exact")
}