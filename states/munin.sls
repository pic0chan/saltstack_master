{% set host_addr = salt['network.interface_ip']('eth0') %}
{% set os_ver = salt['grains.get']('osfinger') %}
{% set munin_server_list = pillar.munin_server_list %}
{% set munin_async_client = pillar.munin_async_client %}

{% if os_ver == 'CentOS Linux-7' %}
/etc/yum.repos.d/epel.repo:
  file.managed:
  - source: salt://files/shared/etc/yum.repos.d/epel.repo_v7
  - mode: 0644
  - user: root
  - group: root
{% elif os_ver == 'CentOS-6' %}
/etc/yum.repos.d/epel.repo:
  file.managed:
  - source: salt://files/shared/etc/yum.repos.d/epel.repo_v6
  - mode: 0644
  - user: root
  - group: root
{% endif %}

{% if os_ver == 'CentOS Linux-7' %}
/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7:
  file.managed:
  - source: salt://files/shared/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
  - mode: 0644
  - user: root
  - group: root
{% elif os_ver == 'CentOS-6' %}
/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6:
  file.managed:
  - source: salt://files/shared/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6
  - mode: 0644
  - user: root
  - group: root
{% endif %}

munin-pkgs:
  pkg.installed:
  - pkgs:
    - munin
    - munin-async
{% if host_addr in munin_server_list %}
    - httpd
    - mod_fcgid
{% endif %}

{% if host_addr in munin_server_list %}
/etc/munin/munin-node.conf:
  file.managed:
  - source: salt://files/munin/etc/munin/munin-node.conf
  - template: jinja
  - context:
    munin_server_list: {{ pillar.munin_server_list }}
  - mode: 0644
  - user: root
  - group: root

/etc/munin/munin-htpasswd:
  file.managed:
  - source: salt://files/munin/etc/munin/munin-htpasswd
  - mode: 0644
  - user: root
  - group: root

/etc/munin/munin.conf:
  file.managed:
  - source: salt://files/munin/etc/munin/munin.conf
  - template: jinja
  - context:
    munin_master: {{ pillar.munin_master }}
    munin_async_client: {{ pillar.munin_async_client }} 
  - mode: 0644
  - user: root
  - group: root

/etc/httpd/conf/httpd.conf:
  file.managed:
{% if os_ver == 'CentOS Linux-7' %}
  - source: salt://files/munin/etc/httpd/conf/httpd.conf_v7
{% elif os_ver == 'CentOS-6' %} 
  - source: salt://files/munin/etc/httpd/conf/httpd.conf
{% endif %}
  - template: jinja
  - mode: 0644
  - user: root
  - group: root

/etc/httpd/conf.d/munin.conf:
  file.managed:
  - source: salt://files/munin/etc/httpd/conf.d/munin.conf
  - template: jinja
  - mode: 0644
  - user: root
  - group: root

/etc/httpd/conf.d/fcgid.conf:
  file.managed:
{% if os_ver == 'CentOS Linux-7' %}
  - source: salt://files/munin/etc/httpd/conf.d/fcgid.conf_v7
{% elif os_ver == 'CentOS-6' %} 
  - source: salt://files/munin/etc/httpd/conf.d/fcgid.conf
{% endif %}
  - mode: 0644
  - user: root
  - group: root

/var/cache/munin:
  file.directory:
  - user: apache
  - group: apache
  - mode: 755
  - makedirs: True

{% else %}
/etc/munin/munin-node.conf:
  file.managed:
  - source: salt://files/shared/etc/munin/munin-node.conf
  - template: jinja
  - context: 
    munin_server_list: {{ pillar.munin_server_list }}
  - mode: 0644
  - user: root
  - group: root

/etc/cron.d/munin:
  file.managed:
  - source: salt://files/shared/etc/cron.d/munin
  - mode: 0644
  - user: root
  - group: root

/etc/munin/munin.conf:
  file.managed:
  - source: salt://files/shared/etc/munin/munin.conf
  - template: jinja
  - mode: 0644
  - user: root
  - group: root
{% endif %}

{% if host_addr in munin_server_list %}
httpd:
  service.running:
  - enable: True
  - watch:
    - file: /etc/httpd/conf/httpd.conf
    - file: /etc/httpd/conf.d/munin.conf
    - file: /etc/httpd/conf.d/fcgid.conf
{% endif %}

munin-node:
  service.running:
  - enable: True
  - watch:
    - file: /etc/munin/munin-node.conf
    - file: /etc/munin/munin.conf
{% if host_addr in munin_server_list %}
    - file: /etc/munin/munin-htpasswd
{% endif %}

{% for munin_async in munin_async_client %}
{% if host_addr in munin_async.ip %}

/var/cache/munin/www:
  file.directory:
  - user: apache
  - group: apache
  - mode: 755
  - makedirs: True

/usr/share/munin/munin-graph:
  file.managed:
    - group: apache

/var/log/munin:
  file.directory:
    - group: apache
    - mode: 775

/var/log/munin-graph.log:
  file.managed:
    - group: apache
    - mode: 664

/var/www/html/munin:
  file.directory:
    - group: apache
    - mode: 775
    - recurse:
      - group
      - mode

munin-async:
  group.present:
    - gid: 4001
    - system: True
  user.present:
    - fullname: munin-async
    - shell: /bin/bash
    - home: /var/lib/munin-async
    - uid: 4001
    - gid: 4001
    - groups:
      - munin
      - munin-async

/var/lib/munin-async/.ssh:
  file.directory:
    - user: munin-async
    - group: munin-async
    - mode: 700
    - makedirs: True

/var/lib/munin/spool:
  file.directory:
    - mode: 775

/var/lib/munin-async/.ssh/authorized_keys:
  file.managed:
    - source: salt://files/munin-async/var/lib/munin-async/ssh/authorized_keys
    - user: munin-async
    - group: munin-async
    - mode: 600
    - template: jinja
    - context:
      auth_command: {{ pillar.munin_async_param.auth_command }}
      auth_pubkey: {{ pillar.munin_async_param.auth_pubkey }}

munin-asyncd:
  service.running:
  - enable: True
{% endif %}
{% endfor %}

