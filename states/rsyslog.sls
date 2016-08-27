install_packages:
  pkg.installed:
    - pkgs:
      - rsyslog

/etc/rsyslog.conf:
  file.managed:
{% if salt['network.interface_ip']('eth0') == '192.168.1.12' %}
    - source: salt://files/syslog/etc/rsyslog.conf
{% else %}
    - source: salt://files/shared/etc/rsyslog.conf
{% endif %}
    - template: jinja
    - mode: 0644
    - user: root
    - group: root

rsyslog:
  service.running:
    - enable: True
    - require:
      - pkg: install_packages
    - watch:
      - file: /etc/rsyslog.conf
