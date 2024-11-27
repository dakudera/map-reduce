#!/bin/bash

# Переменные
SPARK_VERSION="3.4.1"
HADOOP_VERSION="3"
SPARK_ARCHIVE="spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz"
SPARK_URL="https://downloads.apache.org/spark/spark-${SPARK_VERSION}/${SPARK_ARCHIVE}"
INSTALL_DIR="/opt"
SPARK_DIR="${INSTALL_DIR}/spark"

# Установка Java
echo "Установка Java..."
sudo apt update
sudo apt install -y openjdk-11-jdk

# Скачивание и установка Spark
echo "Скачивание Apache Spark..."
wget ${SPARK_URL} -O /tmp/${SPARK_ARCHIVE}

echo "Распаковка Spark..."
sudo tar -xvf /tmp/${SPARK_ARCHIVE} -C ${INSTALL_DIR}
sudo mv ${INSTALL_DIR}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} ${SPARK_DIR}

# Установка pip3, если не установлен
echo "Установка pip3..."
sudo apt install -y python3-pip

# Установка PySpark
echo "Установка PySpark..."
pip3 install pyspark

# Настройка переменных окружения
echo "Настройка переменных окружения..."
echo "export SPARK_HOME=${SPARK_DIR}" >> ~/.bashrc
echo "export PATH=\$SPARK_HOME/bin:\$PATH" >> ~/.bashrc
source ~/.bashrc

# Проверка установки
echo "Проверка установки Spark..."
${SPARK_DIR}/bin/spark-submit --version

