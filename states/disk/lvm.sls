/log:
  file.directory:
    - user: root
    - group: root
    - mode: 775

/log-extend:
  file.directory:
    - user: root
    - group: root
    - mode: 775

#/dev/vdc:
#  lvm.pv_present


VolGroup2:
  lvm.vg_present:
    - devices: /dev/vdc1

LogicalVolume2:
  lvm.lv_present:
    - vgname: VolGroup2
    - extents: 100%FREE
#   - size: 2G
    - require:
      - lvm: VolGroup2

parted_/dev/vdd:
  cmd.run:
    - name: parted -s -- /dev/vdd mklabel gpt mkpart primary xfs 1 -1 set 1 lvm on

/dev/vdd1:
  lvm.pv_present:
    - require:
      - cmd: parted_/dev/vdd

VolGroup3:
  lvm.vg_present:
    - devices: /dev/vdd1

LogicalVolume3:
  lvm.lv_present:
    - vgname: VolGroup3
    - extents: 100%FREE
    - require:
      - lvm: VolGroup3

