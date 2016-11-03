mk_repo1:
  cmd.run:
    - name: svnadmin create /svn1/repo1
    - unless: test -d /svn1/repo1
  
apache_config_repo1:
  file.managed:
    - name: /etc/httpd/conf.d/subversion.conf
    - source: salt://files/svn/etc/httpd/conf.d/subversion.conf
    - mode: 755
    - user: root
    - group: root

