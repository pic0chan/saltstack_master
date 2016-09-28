{% set host_addr = salt['network.interface_ip']('eth0') %}
{% set os_ver = salt['grains.get']('osfinger') %}
{% set munin_list = pillar.munin_list %}

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
{% if host_addr in munin_list %}
    - httpd
    - mod_fcgid
{% endif %}

{% if host_addr in munin_list %}
/etc/munin/munin-node.conf:
  file.managed:
  - source: salt://files/munin/etc/munin/munin-node.conf
  - template: jinja
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
    munin_async_server: {{ pillar.munin_async_server }} 
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

/var/cache/munin/www:
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

{% if host_addr in munin_list %}
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
{% if host_addr in munin_list %}
    - file: /etc/munin/munin-htpasswd
{% endif %}

