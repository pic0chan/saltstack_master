nginx-pkg:
  pkg.installed:
    - pkgs:
      - nginx

install-gunicorn:
  pip.installed:
    - name: gunicorn

install-supervisor:
  pip.installed:
    - name: supervisor

#rename-nginx-conf:
#  file.rename:
#    - name: /etc/nginx/nginx.conf-
#    - source: /etc/nginx/nginx.conf

rename-nginx-conf-default:
  file.rename:
    - name: /etc/nginx/nginx.conf.default-
    - source: /etc/nginx/nginx.conf.default

mkdir_/etc/nginx/conf.d:
  file.directory:
    - name: /etc/nginx/conf.d
    - user: root
    - group: root
    - mode: 755

config-nginx:
  file.managed:
    - name: /etc/nginx/conf.d/netbox.conf
    - source: salt://files/netbox/etc/nginx/conf.d/netbox.conf
    - user: root
    - group: root
    - mode: 744

#delete-config-nginx:
#  file.absent:
#    - name: /etc/nginx/sites-available/default

#symlink-nginx:
#  file.symlink:
#    - name: /etc/nginx/sites-available/netbox
#    - target: /etc/nginx/sites-available/

nginx:
  service.running:
    - enable: True
    - require:
      - pkg: nginx-pkg
    - watch:
      - file: /etc/nginx/conf.d/netbox.conf

gunicorn-config:
  file.managed:
    - name: /opt/netbox/gunicorn_config.py
    - source: salt://files/netbox/opt/netbox/gunicorn_config.py
    - user: root
    - group: root
    - mode: 755

supervisor-config:
  file.managed:
    - name: /etc/supervisord.d/netbox.conf
    - source: salt://files/netbox/etc/supervisord.d/netbox.conf
    - user: root
    - group: root
    - mode: 755

supervisord:
  service.running:
    - watch:
      - file: /etc/supervisord.d/netbox.conf

