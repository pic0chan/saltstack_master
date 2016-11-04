netbox-pkg:
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
      - pkg: netbox-pkg

service_running:
  service.running:
    - name: postgresql
    - enable: True
    - require:
      - pkg: netbox-pkg
      - cmd: postgresql-setup

create_database:
  postgres_database.present:
    - name: netbox
    - db_password: netbox

create_user:
  postgres_user.present:
    - name: netbox

privileges_database:
  postgres_privileges.present:
    - name: netbox
    - object_name: netbox
    - object_type: database
    - privileges:
      - ALL

