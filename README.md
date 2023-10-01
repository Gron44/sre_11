##  Автоматизация: CLI, Data transformation // ДЗ 
### Task
Распарсить вывод API и отдать его в формате Prometheus
#### Цель:
Использовать базовую автоматизацию сбора данных и их конвертацию в нужный формат, по возможности используя утилиты из лекции

#### Описание/Пошаговая инструкция выполнения домашнего задания:
Формат экспортера можно найти [тут](https://github.com/prometheus/docs/blob/master/content/docs/instrumenting/exposition_formats.md#text-format-example)
Варианты:

1. [Приложение](https://github.com/Zenahr/flask-sqlite3-todo-crud/blob/master/app.py) отвечает на три запроса:
    `/ GET`
    `/add POST`
    `/update POST`
    Проверьте код ответа приложения, время ответа либо иные важдые для ваших SLI на данные запросы и отдайте эту информацию в формате Prometheus
2. Получите ответ от [API](http://open-notify.org/Open-Notify-API/ISS-Location-Now/) и сконвертируйте его в формат Prometheus

### Solution

1. скрипт `metrics_app.sh`
2. скрипт `metrics_api.sh`
