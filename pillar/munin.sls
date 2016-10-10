munin_server_namelist:
  munin-async01:
    ip: 192.168.1.14
  munin:
    ip: 192.168.1.15
munin_server_list:
  - 192.168.1.15
  - 192.168.1.14
munin_master: 192.168.1.15
munin_async_client:
  munin-async01:
    ip: 192.168.1.14
munin_async_param:
  auth_command: '/usr/share/munin/munin-async --spooldir /var/lib/munin/spool --spoolfetch'
  auth_pubkey: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCwJsD6T3LETiNvDclWJLrPHUIEIljoejN3IbpYrs9RTx2eaj9xwzAoyCowS3NKFmXkeoz3BN+QirWFZanvwr65U4Qo6tvYBGKLCHRywcxE7ASuRGydHCyHrM9Zde7v/UvWDkLyAEgNPBwjHGBq5uk4/c0gmn1dVhX9EgJBqDg8QQ74Rz9B9bRiXX9SY1eugI/EdILkQW8fYDK4E9QMxGMKX664KZKXAP8blP7bttFHYBmZSjEHCtpCJYeKtMX2Xu9CwhTCz40EAdFZnYzFjbQC5FwCsIFPevzPveZ04Ji8c4rMX5OASeI6tNoC3TAxyS9Aglvfy4Tf396vMFnuiERt munin@munin'

