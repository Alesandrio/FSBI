# FSBI 
Отчет по тестовому заданию "Создание Docker образа"
В Dockerfile содержится базовый образ ubuntu 18.04, в образ контейнера поверх базового образа добавлены дополнительные слои в соответствии с инструкциями из Dockerfile, а именно установка и обновление необходимых библиотек для пакета samtools и biobambam2. \ 
Все устанавливаемые программы стоят отдельным слоем. Папка установки /SOFT/. \
В Dockerfile прописана инструкция установки пактуальной версии программы samtools для обработки коротких фрагментов секвенированной ДНК в форматах SAM или BAM. \ Также прописана установка программы biobambam2 - последняя версия, вместе с libmaus2, необходимой для функционирования biobambam2.



Сборка Docker-образа \
docker build -t SOFT - f /SOFT/Dockerfile . \
Запуск Docker-образа осуществляется следующей командой \
docker run -it
