svn-pkgs:
  pkg.installed:
    - pkgs:
      - subversion
      - httpd
      - mod_dav_svn

auth_svn1:
  file.directory:
    - name: /svn1
    - user: apache
    - group: apache
    - mode: 755
    - recurse:
      - user
      - group
      - mode
    - require:
      - cmd: mk_repo1

svn_service:
  service.running:
    - name: httpd
    - enable: True
    - watch:
      - file: /etc/httpd/conf.d/subversion.conf

