install_packages:
  pkg.installed:
    - pkgs:
      - rsyslog

/etc/rsyslog.conf:
  file.managed:
    - source: salt://files/etc/rsyslog.conf
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
