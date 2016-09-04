{% set host_addr = salt['network.interface_ip']('eth0') %}
{% set os_ver = salt['grains.get']('osfinger') %}

/etc/yum.repos.d/epel.repo:
  file.managed:
{% if os_ver == 'CentOS Linux-7' %}
  - source: salt://files/shared/etc/yum.repos.d/epel.repo_v7
{% elif os_ver == 'CentOS-6' %}
  - source: salt://files/shared/etc/yum.repos.d/epel.repo_v6
{% endif %}
  - mode: 0644
  - user: root
  - group: root

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
{% if host_addr == '192.168.1.15' %}
    - httpd
{% endif %}

/etc/munin/munin-node.conf:
  file.managed:
{% if host_addr == '192.168.1.15' %}
  - source: salt://files/munin/etc/munin/munin-node.conf
{% else %}
  - source: salt://files/shared/etc/munin/munin-node.conf
{% endif %}
  - template: jinja
  - mode: 0644
  - user: root
  - group: root

{% if host_addr == '192.168.1.15' %}
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
{% endif %}

{% if host_addr == '192.168.1.15' %}
httpd:
  service.running:
  - enable: True
{% endif %}

munin-node:
  service.running:
  - enable: True
  - watch:
    - file: /etc/munin/munin-node.conf
{% if host_addr == '192.168.1.15' %}
    - file: /etc/munin/munin-htpasswd
    - file: /etc/munin/munin.conf
{% endif %}

