## Настройка проекта для работы с Airflow
Настройка рабочего окружения производится по официальной инструкции - [Running Airflow in Docker](https://airflow.apache.org/docs/apache-airflow/stable/howto/docker-compose/index.html). Перед началом работы рекомендуется ознакомиться с документацией по [Docker](https://docs.docker.com/get-started/) и [Docker Compose](https://docs.docker.com/get-started/08_using_compose/).

Для работы с Airflow необходимо убедиться, что под Docker Engine выделено достаточное количество памяти. Минимальный размер памяти - **4GB**, рекомендуемый - **8GB**. Проверку можно осуществить следующей командой:
``` bash
docker run --rm "debian:bullseye-slim" bash -c 'numfmt --to iec $(echo $(($(getconf _PHYS_PAGES) * $(getconf PAGE_SIZE))))'
```
В процессе выполнения будет загружен необходимый image, а в конце появится сообщение с количеством выделенной памяти. Например: 
``` bash
Unable to find image 'debian:bullseye-slim' locally
bullseye-slim: Pulling from library/debian
a603fa5e3b41: Pull complete 
Digest: sha256:a42bb0c298cc798f1d3a6c3ee942c54db6919373c88250255ff66aed2fdb7e41
Status: Downloaded newer image for debian:bullseye-slim
8G
```

При необходимости следует изменить размер выделенной памяти. Это можно сделать при помощи инструмента *Docker Desktop*.

Для работы рекомендуется использовать docker-compose версии 1.29.1 и выше. Проверить версию docker-compose можно при помощи команды:
``` bash
docker-compose version
```

Если ваша версия ниже рекомендуемой вы можете обновить docker-compose или работать с более старой версией Airflow. Далее рассмотрены варианты работы с разными версиями docker-compose.

### Настройка окружения

Необходимо создать рабочую директорию и перейти в нее:
``` bash
mkdir airflow
cd airflow
```

В данную директорию необходимо загрузить файл docker-compose.yaml.\
Для docker-compose >= 1.29.1:
``` bash
curl -LfO 'https://airflow.apache.org/docs/apache-airflow/2.5.0/docker-compose.yaml'
```
Для docker-compose < 1.29.1:
``` bash
curl -LfO 'https://airflow.apache.org/docs/apache-airflow/2.1.0/docker-compose.yaml'
```

Перед первым запуском Airflow требуется создать необходимые файлы, директории и инициализировать базу данных. Для этого требуется выполнить следующие команды:
``` bash
mkdir -p ./dags ./logs ./plugins
echo -e "AIRFLOW_UID=$(id -u)" > .env
```
Если файл с именем *.env* не создался, вы можете создать его вручную. Файл должен содержать строку:
``` bash
AIRFLOW_UID=50000
```

Далее необходимо выполнить инициализацию:
``` bash
docker compose up airflow-init
```

После ее завершения вы должны увидедь следующее сообщение в консоли:
``` bash
airflow-init_1       | Upgrades done[task_3.6.py](airflow%2Fdags%2Ftask_3.6.py)
airflow-init_1       | Admin user airflow created
airflow-init_1       | 2.5.0
start_airflow-init_1 exited with code 0
```

Данная инструкция сделана исключительно для быстрого старта работы с Airflow. Она не предназначена для работы в production среде и может содержать ошибки. Наилучшим решением возникающих ошибок является очистка рабочего окружения и повторение с начала. Для очистки можно выполнить команды:
``` bash
docker-compose down --volumes --remove-orphans
cd ../
rm -rf ./airflow
```

### Запуск Airflow
Для запуска необходимо выполнить команду:
``` bash
docker-compose up -d
```

Для проверки корректности запуска можно выполнить команду:
``` bash
docker ps
```
Вывод:
``` bash
CONTAINER ID   IMAGE                  COMMAND                  CREATED              STATUS                        PORTS                                                 NAMES
f011774295b1   apache/airflow:2.1.0   "/usr/bin/dumb-init …"   About a minute ago   Up About a minute (healthy)   8080/tcp                                              airflow_airflow-worker_1
8df5458544aa   apache/airflow:2.1.0   "/usr/bin/dumb-init …"   About a minute ago   Up About a minute (healthy)   0.0.0.0:5555->5555/tcp, :::5555->5555/tcp, 8080/tcp   airflow_flower_1
e51ae699163f   apache/airflow:2.1.0   "/usr/bin/dumb-init …"   About a minute ago   Up About a minute (healthy)   8080/tcp                                              airflow_airflow-scheduler_1
b530485678fe   apache/airflow:2.1.0   "/usr/bin/dumb-init …"   About a minute ago   Up About a minute (healthy)   0.0.0.0:8080->8080/tcp, :::8080->8080/tcp             airflow_airflow-webserver_1
a14a3e292867   redis:latest           "docker-entrypoint.s…"   About a minute ago   Up About a minute (healthy)   0.0.0.0:6379->6379/tcp, :::6379->6379/tcp             airflow_redis_1
a93ed3b62a1d   postgres:13            "docker-entrypoint.s…"   About a minute ago   Up About a minute (healthy)   5432/tcp                                              airflow_postgres_1
```

Для вывода информации о версиях запущенных сервисов необходимо выполнить команду:
``` bash
docker-compose run airflow-worker airflow info
```

Веб интерфейс доступен по адресу:
``` bash
http://localhost:8080
```
Данные для входа - *airflow / airflow*

Если после запуска Docker образов поменялись права созданных директорий, то необходимо изменить права при помощи команды:
``` bash
sudo chmod -R 777 ./dags/ ./logs/ ./plugins/
```

### Создание тестового DAG

Создаем python файл в директории *dags*:
``` bash
touch ./dags/test_dag.py
```

С помощью любого текстового редактора добавляем код в созданный файл.
``` python
from datetime import datetime

from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.python_operator import PythonOperator

def hello():
    print("Hello Airflow!")

# A DAG represents a workflow, a collection of tasks
with DAG(dag_id="test_dag", start_date=datetime(2022, 1, 1), schedule_interval="0 0 * * *") as dag:

    # Tasks are represented as operators
    bash_task = BashOperator(task_id="bash", bash_command="echo hello", do_xcom_push=False)
    python_task = PythonOperator(task_id="python", python_callable=hello, do_xcom_push=False)

    # Set dependencies between tasks
    bash_task >> python_task
```

### Проверка работоспособности созданного DAG

Переходим в пользовательский интерфейс Airflow по адресу:
``` bash
http://localhost:8080
```
Данные для входа - *airflow / airflow*

Находим и запускаем наш граф - имя *test_dag*. Обе задачи должны быть в статусе *success*, в логах задач должны быть выведены наши принты.
``` bash
[2022-12-05 14:02:53,040] {subprocess.py:79} INFO - hello
[2022-12-05 14:02:53,823] {logging_mixin.py:104} INFO - Hello Airflow!
```
