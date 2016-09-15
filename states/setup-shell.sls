shell_packages:
  pkg.installed:
    - pkgs:
      - git
      - vim-enhanced

/root/.bashrc:
  file.managed:
    - source: salt://files/shared/home/bashrc
    - template: jinja
    - mode: 0644
    - user: root
    - group: root

/etc/profile:
  file.managed:
    - source: salt://files/shared/etc/profile
    - template: jinja
    - mode: 0644
    - user: root
    - group: root

