from pyspark import SparkContext

def print_data(result):
    print(f"{'Word':<20} {'Count':<5}")
    print("-" * 25) 
    for word, count in result:
        print(f"{word:<20} {count:<5}")

    with open("word_counts.txt", "w", encoding="utf-8") as f:
        f.write(f"{'Word':<20} {'Count':<5}\n")
        f.write("-" * 25 + "\n")
        for word, count in result:
            f.write(f"{word:<20} {count:<5}\n")


def processing_data():
    sc = SparkContext.getOrCreate()
    text_file = sc.textFile("file1.txt")
    words = text_file.flatMap(lambda line: line.split(" "))
    word_pairs = words.map(lambda word: (word.lower(), 1))
    word_counts = word_pairs.reduceByKey(lambda a, b: a + b)
    sorted_word_counts = word_counts.sortBy(lambda x: x[1], ascending=False)
    result = sorted_word_counts.collect()
    print_data(result=result)
    sc.stop()


if __name__ == '__main__':
    processing_data()