{% if salt['network.interface_ip']('eth0') == '192.168.1.12' %}
/etc/sysconfig/iptablesrs:
  file.managed:
    - source: salt://files/syslog/etc/sysconfig/iptables
    - template: jinja
    - mode: 0644
    - user: root
    - group: root
{% endif %}

iptables:
  service.running:
    - enable: True
    - watch:
      - file: /etc/sysconfig/iptables
