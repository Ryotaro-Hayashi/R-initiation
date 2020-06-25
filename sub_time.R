# csvからdateTimeを抽出して変数に格納
# start time
jaken_create <- read.csv("/Users/ryotarohayashi/Desktop/R-statistics/jaken_create.csv", header = TRUE, skip = 0)$dateTime
# end time
jaken_textout <- read.csv("/Users/ryotarohayashi/Desktop/R-statistics/jaken_textout.csv", header = TRUE, skip = 0)$dateTime

# the list for the spent time per 1 person
subTime <- c() # リストとベクトルは違う！

for (i in 1:10) {
  # parse the date to minutes unit
  create_list <- strptime(jaken_create[i], format = "%Y-%m-%dT%H:%M:%S")
  textout_list <- strptime(jaken_textout[i], format = "%Y-%m-%dT%H:%M:%S")
  
  # parse the minutes unit to the second unit
  time <- as.numeric(textout_list-create_list, units = "secs")
  
  subTime <- c(subTime, time)
}

# consoleに出力
str(subTime)
print(subTime)

mean(subTime) # 平均値を求める
