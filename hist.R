# データフレーム生成時にfactor型で読むように第四引数で指定
jaken_csv <- read.csv("/Users/ryotarohayashi/Desktop/R-statistics/jaken.csv", header = TRUE, skip = 0, stringsAsFactors = T)

jaken_create <- subset(jaken_csv, jaken_csv$op=="cc_create")$dateTime
jaken_textout <- subset(jaken_csv, jaken_csv$op=="cc_textOut")$dateTime

subTime <- c()
for (i in 1:10) {
  # 日時をパースする
  jcl <- strptime(jaken_create[i], format = "%Y-%m-%dT%H:%M:%S")
  jtl <- strptime(jaken_textout[i], format = "%Y-%m-%dT%H:%M:%S")
  # 秒単位に直す
  t <- as.numeric(jtl-jcl, units = "secs")
  subTime <- c(subTime, t)
}

# 度数分布を描画する
dosuu.bunpuzu <- function(i, df) {
  # []で切り取り（i行目だけ切り取り）
  x <- df[, i]
  print(x)
  if (is.factor(x)) {
    #変数xがfactorのときは棒グラフを描く
    barplot(table(x), xlab=colnames(df)[i], ylab="Frequency") 
  } else {
    #変数xがfactorではないときはヒストグラムを描く 
    hist(x, right=FALSE, main="", xlab=colnames(df)[i])
  }
}

dosuu.bunpuzu(4, jaken_csv)
