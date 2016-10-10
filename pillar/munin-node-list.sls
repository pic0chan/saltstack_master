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

