import os
import random
import psycopg2
from pathlib import Path
from datetime import datetime

from airflow import DAG
from airflow.models import Variable
from airflow.hooks.base import BaseHook
from airflow.operators.bash import BashOperator
from airflow.operators.python import BranchPythonOperator
from airflow.contrib.sensors.file_sensor import FileSensor
from airflow.operators.python_operator import PythonOperator
from airflow.contrib.sensors.python_sensor import PythonSensor
from airflow.providers.postgres.operators.postgres import PostgresOperator

def hello():
    print("Hello Airflow!")

def random_values():

    # a. Генерация двух произвольных чисел
    val_1 = random.randint(0, 100)
    val_2 = random.randint(0, 100)

    print(f'First value: {val_1}, second value: {val_2}')

    file_path = Variable.get("file_task_3_6_path")

    # Обновление переменной с количеством запусков
    count = int(Variable.get("run_count"))
    # Variable.set("run_count", int(column_number) + 1)
    Variable.update(key="run_count", value=str(count + 1))

    Path(file_path).touch(exist_ok=True)

    # c. Запись сгенерированных чисел в файл
    with open(file_path, "r+") as file:
        lines = file.readlines()
        file.seek(0)
        file.truncate()

        if len(lines)-1 != count:
            print(f'len(lines): {len(lines)}')
            Variable.update(key="run_count", value=str(len(lines) + 1))

        # e. Запись файла без последней строки
        file.writelines(lines[:-1])

        file.write(f'{val_1} {val_2} \n')

# d. Функция для обработки данных из файла
def perform_computations():
    sum_1 = 0
    sum_2 = 0

    file_path = Variable.get("file_task_3_6_path")

    with open(file_path, "r+") as file:
        for line in file.readlines():
            val_1, val_2 = line.strip().split(" ")
            sum_1 += int(val_1)
            sum_2 += int(val_2)
            print(f'Values: {val_1}, {val_2}')

        file.write(f'{sum_1-sum_2}')

# j. Оператор ветвления
def get_choise(**kwargs):
    ti = kwargs['ti']

    file_is_ok, _, _, _ = ti.xcom_pull(key='file_is_ok', task_ids='custom_sensor')

    if file_is_ok:
        return 'create_table'
    else:
        return 'exception'

def check_file(**kwargs):
    ti = kwargs['ti']

    file_path = Variable.get("file_task_3_6_path")
    x, sum_1, sum_2, res = 0, 0, 0, 0
    file_ex, count_res, summ_res = False, False, False
    if os.path.exists(file_path):
        file_ex = True
        count = int(Variable.get("run_count"))
        with open(file_path, "r+") as file:

            for line in file.readlines():
                x += 1
                split = line.strip().split(" ")
                if len(split) > 1:
                    val_1, val_2 = split
                    sum_1 += int(val_1)
                    sum_2 += int(val_2)
                else:
                    res = int(split[0])

        print(f'(x - 1) == count and res == (sum_1-sum_2): {(x - 1)} == {count} and {res} == {(sum_1-sum_2)}')
        if (x - 1) == count:
            count_res = True
        if res == (sum_1-sum_2):
            summ_res = True

    if file_ex and count_res and summ_res:
        ti.xcom_push(value=[True, file_ex, count_res, summ_res], key='file_is_ok')
        return True
    else:
        ti.xcom_push(value=[False, file_ex, count_res, summ_res], key='file_is_ok')
        return False

# j. Обработка исключения
def perform_exception(**kwargs):
    ti = kwargs['ti']

    file_is_ok, file_ex, count_res, summ_res = ti.xcom_pull(key='file_is_ok', task_ids='custom_sensor')

    print(f'There are problems with the file:'
          f'file exists = {file_ex},'
          f'count of lines and runs = {count_res},'
          f'result of computations= {summ_res}')

def get_conn_credentials(conn_id) -> BaseHook.get_connection:
    conn_to_airflow = BaseHook.get_connection(conn_id)
    return conn_to_airflow

# j. Создание таблицы в БД
def create_table():
    conn_id = Variable.get("conn_id")
    conn_to_airflow = get_conn_credentials(conn_id)

    pg_hostname, pg_port, pg_username, pg_pass, pg_db = conn_to_airflow.host, conn_to_airflow.port, \
        conn_to_airflow.login, conn_to_airflow.password, \
        conn_to_airflow.schema

    pg_conn = psycopg2.connect(host=pg_hostname, port=pg_port, user=pg_username, password=pg_pass, database=pg_db)

    cursor = pg_conn.cursor()

    cursor.execute("CREATE TABLE IF NOT EXISTS values_table (id serial PRIMARY KEY, val_1 integer, val_2 integer);")

    with open(Variable.get("file_task_3_6_path"), "r+") as file:
        for line in file.readlines():
            split = line.strip().split(" ")
            if len(split) > 1:
                val_1, val_2 = split
                cursor.execute("INSERT INTO values_table (val_1, val_2) VALUES (%s, %s)", (val_1, val_2))

    pg_conn.commit()

    cursor.close()
    pg_conn.close()


# A DAG represents a workflow, a collection of tasks
# https://crontab.guru/
# f. Настройка DAG
with DAG(dag_id="task_dag", start_date=datetime(2022, 12, 8), catchup=False, schedule_interval="1-5 * * * *",
         max_active_runs=5, default_args={'retries': 5}) as dag:

    # Tasks are represented as operators
    bash_task = BashOperator(task_id="bash", bash_command="echo 'Hello Airflow'", do_xcom_push=False)
    python_task = PythonOperator(task_id="python", python_callable=hello, do_xcom_push=False)
    python_write_file = PythonOperator(task_id="write_file", python_callable=random_values, do_xcom_push=False)
    python_computations = PythonOperator(task_id="computations", python_callable=perform_computations, do_xcom_push=False)

    bash_end_task = BashOperator(task_id="bash_end", bash_command="echo 'Bye Airflow'", trigger_rule='one_success',
                                 do_xcom_push=False)

    # Сделал для примера
    # file_sensor = FileSensor(
    #     task_id='file_sensor_check',
    #     poke_interval=6,
    #     timeout=18,
    #     soft_fail=False,
    #     retries=2,
    #     fs_conn_id='fs_default',
    #     filepath='/opt/airflow/task_file.txt',
    #     dag=dag
    # )

    choose_brach = BranchPythonOperator(
        task_id='choose_brach',
        python_callable=get_choise,
        do_xcom_push=False
    )

    custom_sensor = PythonSensor(
        task_id='custom_sensor',
        poke_interval=6,
        timeout=60,
        mode="reschedule",
        python_callable=check_file,
        dag=dag,
        do_xcom_push=True
    )

    exception_task = PythonOperator(task_id="exception", python_callable=perform_exception, do_xcom_push=False)
    create_table_task = PythonOperator(task_id="create_table", python_callable=create_table, do_xcom_push=False)

    # k. Создание новой колонки при помощи PostgresOperator (не получилось реализовать логику вычислений как в задании)
    create_col_task = PostgresOperator(
        task_id="create_column",
        sql="""
                ALTER TABLE values_table
                ADD COLUMN IF NOT EXISTS coef integer;
                UPDATE values_table SET coef = val_1 - val_2;
              """,
        postgres_conn_id=Variable.get("conn_id"),
        trigger_rule='one_success',
        dag=dag
    )

    # Set dependencies between tasks
    bash_task >> python_task >> python_write_file >> python_computations >> \
    custom_sensor >> choose_brach >> [create_table_task,exception_task] >> create_col_task >> bash_end_task
