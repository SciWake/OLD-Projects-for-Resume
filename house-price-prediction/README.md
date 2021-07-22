# 🏡 Предсказание цен на недвижимость

### Описание проекта:
* **Ссылка на соревнование Kaggle:** https://www.kaggle.com/c/realestatepriceprediction/submit
* **Качество модели:** 0.75843
* **Используемая модель:** CatBoost
* **Метрика:** R2

#### [`File "Data_preprocessing.ipynb"`](https://github.com/bimastics/Projects-for-Resume/blob/master/house-price-prediction/Data_preprocessing.ipynb) 

В данном Notebook визуально представлены выбросы в данных, под каждым графиком имеется таблица с выбросами, которые обрабатываются с использованием Pandas.

#### [`File "Model.ipynb"`](https://github.com/bimastics/Projects-for-Resume/blob/master/house-price-prediction/Model.ipynb) 

Данный Notebook демонстрирует использование модели машинного обучения CatBoost. После обучения модели были построены графики библиотеки shap, которая красивыми и наглядными визуализациями позволяет оценить влияние каждого признака на модель. Последним этапом считается загрузка результатов предсказания на платформу Kaggle.

### Заметки:
* Описание признаков набора данных расположены в файле "Data_preprocessing.ipynb";
* Некоторые объяснения описаны внутри ipynb файлов.
