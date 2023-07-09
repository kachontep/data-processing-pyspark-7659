import os

from pyspark.sql import SparkSession

spark = (SparkSession
    .builder
    .getOrCreate()
)

lines = spark.sparkContext.textFile(os.path.join(os.getenv("SPARK_HOME"), "README.md"))

print("Reading $SPARK_HOME/READMD.md.")

line_num = lines.count()

print("The number of lines : {}".format(line_num))

words = lines.flatMap(lambda l: l.split(" "))

words = words.map(lambda w: w.lower())

word_pairs = words.map(lambda w: (w, 1))

word_counts = word_pairs.reduceByKey(lambda n1, n2: n1 + n2)

word_ranks = word_counts.sortBy(lambda wc: wc[1], ascending=False)

print(word_ranks.take(50))
