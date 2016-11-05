postgres-pkg:
  pkg.installed:
    - pkgs:
      - postgresql
      - postgresql-server
      - postgresql-devel
      - python-psycopg2

postgresql-setup:
  cmd.run:
    - name: postgresql-setup initdb
    - unless: ls `systemctl show -p Environment postgresql.service | sed 's/^Environment=//' | tr ' ' '\n' | sed -n 's/^PGDATA=//p' | tail -n 1`
    - watch:
      - pkg: postgres-pkg

service_running:
  service.running:
    - name: postgresql
    - enable: True
    - require:
      - pkg: postgres-pkg
      - cmd: postgresql-setup

create_database:
  postgres_database.present:
    - name: netbox
    - db_password: netbox

create_user:
  postgres_user.present:
    - name: netbox
    - password: netbox

privileges_database:
  postgres_privileges.present:
    - name: netbox
    - object_name: netbox
    - object_type: database
    - privileges:
      - ALL

netbox-pkg:
  pkg.installed:
    - pkgs:
      - epel-release
      - gcc
      - python
      - python-devel
      - python-pip
      - libxml2-devel
      - libxslt-devel
      - libffi-devel
      - graphviz
      - openssl-devel

mkdir_netbox:
  file.directory:
    - name: /opt/netbox

download_netbox:
  cmd.run:
    - name: git clone -b master https://github.com/digitalocean/netbox.git /opt/netbox
    - unless: ls /opt/netbox/netbox

pip_netbox_require:
  cmd.run:
    - name: pip install -r /opt/netbox/requirements.txt
    - unless: pip freeze 2>&1 | grep django

#rename_configuration_script:
#  file.rename:
#    - name: /opt/netbox/netbox/netbox/configuration.py
#    - source: /opt/netbox/netbox/netbox/configuration.example.py

netbox_configuration:
  file.managed:
    - name: /opt/netbox/netbox/netbox/configuration.py
    - source: salt://files/netbox/opt/netbox/netbox/netbox/configuration.py
    - template: jinja
    - context:
      hostlist: {{ pillar.netbox_config.host_list }}
    - user: root
    - group: root
    - mode: 755

# 以下、CLI で打ってください... unless 条件が分からない...

# データベースに初期データ投入
#database_migration:
#  cmd.run:
#    - name: python /opt/netbox/netbox/manage.py migrate

# 対話式... user, password, email 聞かれる. password は netbox にしたよ
#create_superuser:
#  cmd.run:
#    - name: python /opt/netbox/netbox/manage.py createsuperuser 

# python のライブラリとかコピーしまくる
#collect_static_file:
#  cmd.run:
#    - name: python /opt/netbox/netbox/manage.py collectstatic

# 初期データの読み込み？
#loaddata_initial:
#  cmd.run:
#    - name: python /opt/netbox/netbox/manage.py loaddata initial_data

# アプリ起動？
#start_app:
#  cmd.run:
#    - name: python /opt/netbox/netbox/manage.py runserver 0.0.0.0:8000 --insecure

