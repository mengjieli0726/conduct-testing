#
#Sample Spark application for use with GPU resources

# To run this example use
# ./bin/spark-submit examples/src/main/r/wordcount_gpu.R <infile> <outfile>

# Load SparkR library into your R session
library(SparkR)

args <- commandArgs(trailing = TRUE)

if (length(args) != 2) {
  print("Usage: wordcount_gpu.R  <infile> <outfile>")
  #print("Usage: wordcount_gpu.R <outfile>")
  q("no")
}

## Initialize SparkSession
sc <- sparkR.session(appName = "wordcount_gpu")

infile <- args[[1]]

# Create a local R DF
#trace in the https://issues.apache.org/jira/browse/SPARK-23213?jql=project%20%3D%20SPARK%20AND%20component%20%3D%20SparkR
lines <- read.text(args[[1]])
tokens <- selectExpr(lines, "explode(split(value, ' ')) as word")

#words=c("you","me","hello","nice","you","you","me","you","hello","hello","nice","color")
#lines <- SparkR:::parallelize(sc,words)
#split tasks into 2 parts, one for cpu, the other one for gpu
rdd_list <- randomSplit(tokens, c(7,3), 2)

cpu_tokens <- SparkR:::toRDD(rdd_list[[1]])
gpu_tokens <- SparkR:::toRDD(rdd_list[[2]])
cpu_map <- SparkR:::map(cpu_tokens,function(x){c(x, 1)})
cpu_counts <- SparkR:::reduceByKey(cpu_map, "+", 2L)
gpu_token_trans <- SparkR:::gpu(gpu_tokens,TRUE)
print(gpu_token_trans)
print("GPU gpu_token_trans generated.")
#gpu_map <- SparkR:::map(gpu_tokens ,function(x){c(x, 1)})
gpu_map <- SparkR:::map(gpu_token_trans ,function(x){c(x, 1)})
print("GPU map tasks start to work.")
gpu_counts <- SparkR:::reduceByKey(gpu_map, "+", 2L)
print("GPU reduceByKey tasks start to work.")
# union the compute from cpu and gpu
unioned <- SparkR:::unionRDD(cpu_counts,gpu_counts)
counts  <- SparkR:::reduceByKey(unioned, "+", 2L)
#sort_counts <- SparkR:::sortBy(counts, function(x) { x })
print(" saveAsTextFile action start to work.")

SparkR:::saveAsTextFile(counts,args[[2]])

# Stop the SparkSession now
sparkR.session.stop()
