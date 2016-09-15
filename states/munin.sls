{% set host_addr = salt['network.interface_ip']('eth0') %}
{% set os_ver = salt['grains.get']('osfinger') %}

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
{% if host_addr in ['192.168.1.15', '192.168.1.19'] %}
    - httpd
    - mod_fcgid
{% endif %}

{% if host_addr in ['192.168.1.15', '192.168.1.19'] %}
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

{% if host_addr in ['192.168.1.15', '192.168.1.19'] %}
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
{% if host_addr in ['192.168.1.15', '192.168.1.19'] %}
    - file: /etc/munin/munin-htpasswd
{% endif %}

