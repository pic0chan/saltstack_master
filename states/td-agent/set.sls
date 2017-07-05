set_/etc/yum.repos.d/td-agent.repo:
  file.managed:
    - name: /etc/yum.repos.d/td-agent.repo
    - source: salt://td-agent/files/td-agent.repo
    - user: root
    - group: root
    - mode: 644

install_td-agent:
  pkg.installed:
    - name: td-agent
    - require:
      - file: set_/etc/yum.repos.d/td-agent.repo

set_/etc/td-agent/td-agent.conf:
  file.managed:
    - name: /etc/td-agent/td-agent.conf
    - source: salt://td-agent/files/td-agent.conf.client
    - user: root
    - group: root
    - mode: 644

