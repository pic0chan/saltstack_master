/etc/sysconfig/iptables:
  file.managed:
{% if salt['network.interface_ip']('eth0') == '192.168.1.12' %}
    - source: salt://files/syslog/etc/sysconfig/iptables
{% endif %}
    - template: jinja
    - mode: 0644
    - user: root
    - group: root

iptables:
  service.running:
    - enable: True
    - watch:
      - file: /etc/sysconfig/iptables
