<h1 align="center">Сбор данных сервиса Zillow</h1>

![Re](https://github.com/bimastics/repo/blob/main/1.png)

## :milky_way: Описание проекта:

В этом проекте используется фреймворк Scrapy, который решает задачи сбора информации. Для сбора данных был выбран ресурс Zillow - это американская компания по продаже онлайн-недвижимости. В сбор данных производился в штате Колифорния, город Лос-Анджелес. После сбора данных, произведена обработка пропущенных значений с последующей визулаизацей на нескольких графиках.

**Этапы  проекта:**
1. Сбор данных используюя Scrapy с сохранением в .csv файл;
2. Обработка пропущенных значений;
3. Визуализация данных.

## :file_folder: Файлы проекта:

### :open_file_folder: [`zillowparse`](https://github.com/bimastics/Projects-for-Resume/tree/master/Zillow-data-collection/zillowparse)

Директория содержит код, который производит сбор данных. Основные файлы, которые содержит данная директория:

* [spiders](https://github.com/bimastics/Projects-for-Resume/tree/master/Zillow-data-collection/zillowparse/spiders) - Эта директория содержит файлы пауков, которые производят обход страниц для последующего сбора данных. В этом проекте, хранится только один файл zillow.py.
* [items.py](https://github.com/bimastics/Projects-for-Resume/blob/master/Zillow-data-collection/zillowparse/items.py) - Файл содержит код промежуточной обработки данных.
* [pipelines.py](https://github.com/bimastics/Projects-for-Resume/blob/master/Zillow-data-collection/zillowparse/pipelines.py) - Позволяет управлять готовым набором данных, наприм, отправлять полученную информацию в базу данных.
* [settings.py](https://github.com/bimastics/Projects-for-Resume/blob/master/Zillow-data-collection/zillowparse/settings.py) - Файл настроек, который регламентирует взаимодействие файлов проекта.
* [start_parse.py](https://github.com/bimastics/Projects-for-Resume/blob/master/Zillow-data-collection/zillowparse/start_parse.py) - Файл производит запусе пауков, которые выполняют обход ссылок ресурса.

### :page_facing_up: [`Data_processing.ipynb`](https://github.com/bimastics/Projects-for-Resume/blob/master/Zillow-data-collection/Data_processing.ipynb)

Данный Notebook используется для обработки пропущенных значений. Это имеет место быть, так как после сбора, можно сформировать, например, соревнование на Kaggle для предсказания цены на недвижимость.

### :open_file_folder: [`Data_visualization.ipynb`](https://github.com/bimastics/Projects-for-Resume/blob/master/Zillow-data-collection/Data_visualization.ipynb)

Данный Notebook используется для визуализации данных. Визуализация производится на картах, что позволят оценить плотность продажи недвижимости в разных районах города.

### :open_file_folder: [`input_data`](https://github.com/bimastics/Projects-for-Resume/tree/master/Zillow-data-collection/input_data)

Входные данные, которые можно использовать в дальнейшем. Внутри директории содержатся следующие файлы:

* database.csv - Данные, которые были получены методами Scrapy;
* database_new.csv - Данные, после обработки пропусков.


### :open_file_folder: [`images_zillow`](https://github.com/bimastics/Projects-for-Resume/tree/master/Zillow-data-collection/images_zillow)

Внутри директории расположены дополнительные папки с идетификаторами квартиры, внутри которых содержатся фотографии загруженные пользователями для продажи недвижимости. Дання директория содана для примера того, как хранятся фотографии после сбора данных.

Пример фотографии, которая была скачана:

![text](https://github.com/bimastics/Projects-for-Resume/blob/master/Zillow-data-collection/images_zillow/80739324/e17d14bbeefc40fdad5e652c549c152f-uncropped_scaled_within_1536_1152.jpg)
