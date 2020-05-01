# house-price-prediction

### Project description:
* **Link to Kaggle:** https://www.kaggle.com/c/realestatepriceprediction/submit
* **Score:** 0.75232
* **The model used:** GradientBoostingRegressor
* **Metrics:** R2

`File "Data_preprocessing.ipynb"` - В данном Notebook визульно представлены выбросы в данных, под каждым графиком имется таблица с выбросами, которые обрабатываются с использованием Pandas.

`File "Model.ipynb"` - В данном Notebook реализована модель ("GradientBoostingRegressor"), после обработки было проверенно множество моделей, лучшей стабильностью облатает данная модель, но имеет достаточно высокий индекс переобучения. XGBoost имеет аналогичный показатель R2, но меньший уровень переобучения ~0.12 при хорошей настройке гиперпараметров.

### Notes:
* Описание признаков DataSet находятся в файле "Data_preprocessing.ipynb"
