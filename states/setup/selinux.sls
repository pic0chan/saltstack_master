disable-selinux:
  file.managed:
    - name: /etc/selinux/config
    - source: salt://files/shared/etc/selinux/config
    - user: root
    - group: root
    - mode: 644

permissive-selinux:
  cmd.run:
    - name: setenforce 0

