munin_node_list:
  munin-async01:
    hostname: munin-async01
    ip: 192.168.1.14
    munin_server: munin-async01

  kibana4:
    hostname: kibana4
    ip: 192.168.1.37
    group: Dev
    alarm_rules:
      - 'df._dev_vda1.warning 75'
      - 'df._dev_vda1.critical 80'
      - 'df_inode._dev_vda1.warning 75'
      - 'df_inode._dev_vda1.critical 80'
      - 'load.load.warning 8'
      - 'load.load.critical 15'
    munin_server: munin-async01

  nagioslog:
    hostname: nagioslog
    ip: 192.168.1.12
    group: Dev
    alarm_rules:
      - 'df._dev_vda1.warning 75'
      - 'df._dev_vda1.critical 80'
      - 'df_inode._dev_vda1.warning 75'
      - 'df_inode._dev_vda1.critical 80'
      - 'load.load.warning 8'
      - 'load.load.critical 15'
    munin_server: munin-async01

  ceph-node01:
    hostname: ceph-node01
    ip: 192.168.1.6
    group: Dev
    alarm_rules:
      - 'df._dev_vda1.warning 75'
      - 'df._dev_vda1.critical 80'
      - 'df_inode._dev_vda1.warning 75'
      - 'df_inode._dev_vda1.critical 80'
      - 'load.load.warning 1'
      - 'load.load.critical 2'
    munin_server: munin-async01

  ceph-node02:
    hostname: ceph-node02
    ip: 192.168.1.16
    group: Dev
    alarm_rules:
      - 'df._dev_vda1.warning 75'
      - 'df._dev_vda1.critical 80'
      - 'df_inode._dev_vda1.warning 75'
      - 'df_inode._dev_vda1.critical 80'
      - 'load.load.warning 1'
      - 'load.load.critical 2'
    munin_server: munin-async01

  ceph-node03:
    hostname: ceph-node03
    ip: 192.168.1.18
    group: Dev
    alarm_rules:
      - 'df._dev_vda1.warning 75'
      - 'df._dev_vda1.critical 80'
      - 'df_inode._dev_vda1.warning 75'
      - 'df_inode._dev_vda1.critical 80'
      - 'load.load.warning 1'
      - 'load.load.critical 2'
    munin_server: munin-async01

  ceph-admin:
    hostname: ceph-admin
    ip: 192.168.1.20
    group: Dev
    alarm_rules:
      - 'df._dev_vda1.warning 75'
      - 'df._dev_vda1.critical 80'
      - 'df_inode._dev_vda1.warning 75'
      - 'df_inode._dev_vda1.critical 80'
      - 'load.load.warning 1'
      - 'load.load.critical 2'
    munin_server: munin-async01

