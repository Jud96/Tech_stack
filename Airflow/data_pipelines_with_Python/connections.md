## connections 

```python 
import getpass
import os
```

```python
Note: Double curly braces ('{{') necessary when using string formatting

#Dummy connection with no real data:
command = '''sudo -S docker-compose run airflow-worker connections add 'my_prod_db' \
    --conn-json '{{ \
        "conn_type": "my-conn-type", \
        "login": "{}", \
        "password": "{}", \
        "host": "my-host", \
        "port": 1234, \
        "schema": "my-schema", \
        "extra": {{ \
            "param1": "val1", \
            "param2": "val2" \
        }} \
    }}'
'''.format('test_user','test_passss')

os.system('echo {} | {}'.format(getpass.getpass(),command))
```

```python
#Note: Double curly braces ('{{') necessary when using string formatting

#Inputting AWS Credentials
import configparser
#AWS Credentials
aws_path = "/home/rambino/.aws/credentials"
aws_cred = configparser.ConfigParser()
aws_cred.read(aws_path)

command = '''sudo -S docker-compose run airflow-worker connections add 'aws_credentials' \
    --conn-json '{{ \
        "conn_type": "aws", \
        "login":"{}", \
        "password":"{}", \
        "extra": {{ \
            "region_name": "us-east-1" \
        }} \
    }}'
'''.format(
    aws_cred['default']['aws_access_key_id']
    ,aws_cred['default']['aws_secret_access_key']
)

os.system('echo {} | {}'.format(getpass.getpass(),command))
```

```python
#Note: Double curly braces ('{{') necessary when using string formatting
command = '''sudo -S docker-compose run airflow-worker airflow variables set test_variable \
    {\"test_key\":\"test_val\"}
'''

os.system('echo {} | {}'.format(getpass.getpass(),command))
```

```python