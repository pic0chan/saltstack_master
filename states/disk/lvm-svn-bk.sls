parted_/dev/vdb:
  cmd.run:
    - name: parted -s -- /dev/vdb mklabel gpt mkpart primary ext4 1 -1 set 1 lvm on
    - unless: ls /dev/ | grep vdb1
    - order: 1

pvcreate_/dev/vdb1:
  lvm.pv_present:
    - name: /dev/vdb1
    - require:
      - cmd: parted_/dev/vdb
    - order: 2

vgcreate_/dev/vdb1:
  lvm.vg_present:
    - name: VolGroup1
    - devices: /dev/vdb1
    - order: 3 

lvcreate_LogicalVolume1:
  lvm.lv_present:
    - name: LogicalVolume1
    - vgname: VolGroup1
    - extents: 100%FREE
    - require:
      - lvm: vgcreate_/dev/vdb1
    - order: 4

mkdir_/svn1:
  file.directory:
    - name: /svn1
    - mode: 755
    - user: root
    - group: root
    - order: 5

format_/dev/VolGroup1/LogicalVolume1:
  cmd.run:
    - name: mkfs.ext4 /dev/VolGroup1/LogicalVolume1
    - unless: blkid /dev/VolGroup1/LogicalVolume1 | grep ext4

mount_/dev/vdb1:
  mount.mounted:
    - name: /svn1
    - device: /dev/VolGroup1/LogicalVolume1
    - fstype: ext4
    - mkmnt: True
    - persist: True
    - opts:
      - defaults
    - require:
      - file: mkdir_/svn1
    - order: 6

