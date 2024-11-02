###################
# To demonstrate all the aforementioned concepts, let’s go back to the example workflow
#  mentioned at the beginning of this article. We will develop a pipeline that trains
# a model and deploy it in Kubernetes. More specifically, the DAG will consist of 5 tasks
#  1.   Read images from an AWS s3 bucket
#  2.   Preprocess the images using Pytorch
#  3.   Fine-tune a ResNet model with the downloaded images
#  4.   Upload the model in S3
#  5.   Deploy the model in a Kubernetes Cluster

from airflow import DAG
import datetime
from airflow.operators.python_operator import PythonOperator
from airflow.providers.amazon.aws.hooks.s3 import S3Hook
from airflow.operators.s3_file_transform_operator import S3FileTransformOperator
from airflow.providers.cncf.kubernetes.operators.kubernetes_pod import KubernetesPodOperator

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': airflow.utils.dates.days_ago(2),
    'retries': 1,
    'retry_delay': datetime. timedelta(hours=1),
}

dag = DAG(
    'resnet_model',
    default_args=default_args,
    description='A simple DAG to demonstrate Airflow with PyTorch and Kubernetes',
    schedule_interval='@daily',
    catchup=False
)

def read_images_from_s3(**kwargs):
    s3_conn = S3Hook(aws_conn_id='aws_default')
    images = []
    for obj in s3_conn.get_bucket('mybucket').objects.all():
        images.append(obj.key)
    kwargs['ti'].xcom_push(key='images', value=images)

read_images = PythonOperator(
    task_id='read_images',
    python_callable=read_images_from_s3,
    provide_context=True,
    dag=dag
)

def preprocess_images(images, **kwargs):

    images = kwargs['ti'].xcom_pull(task_ids='read_images_from_s3', key='images')

    # Perform basic preprocessing using PyTorch
    
    kwargs['ti'].xcom_push(key='images', value=train_images)


def fit_model(preprocessed_images, **kwargs):

    train_images = kwargs['ti'].xcom_pull(task_ids=preprocess_images, key='train_images')

    # Fit the using PyTorch
     
    torch.save(model, 'trained_model.pt')

    
preprocess = PythonOperator(
    task_id='preprocess',
    python_callable=preprocess,
    provide_context=True,
    dag=dag
)

fit_model = PythonOperator(
    task_id='fit_model',
    python_callable=fit_model,
    provide_context=True,
    dag=dag
)

upload_model = S3FileTransferOperator(
    task_id='upload_model',
    source_base_path='.',
    source_key='trained_model.pt',
    dest_s3_bucket='my-model-bucket',
    dest_s3_key='trained_model.pt',
    dag=dag
)

deploy_model = KubernetesPodOperator(
    namespace='default',
    image='myimage:latest',
    name='deploy-model',
    task_id='deploy_model',
    cmds=['python', 'deploy.py'],
    arguments=[model],
    is_delete_operator_pod=True,
    hostnetwork=False,
    dag=dag
)

read_images >> preprocess >> fit_model >> upload_model >> deploy_model