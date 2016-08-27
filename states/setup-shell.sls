/root/.bashrc:
  file.managed:
    - source: salt://files/home/bashrc
    - template: jinja
    - mode: 0644
    - user: root
    - group: root

/etc/profile:
  file.managed:
    - source: salt://files/etc/profile
    - template: jinja
    - mode: 0644
    - user: root
    - group: root

