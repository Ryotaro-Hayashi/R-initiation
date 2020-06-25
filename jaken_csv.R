jaken_csv <- read.csv("/Users/ryotarohayashi/Desktop/R-statistics/jaken.csv", header = TRUE, skip = 0)

# subset で1つの csv からデータを抽出
jaken_create <- subset(jaken_csv, jaken_csv$op="cc_create")$dateTime
jaken_textout <- subset(jaken_csv, jaken_csv$op="cc_textOut")$dateTime