  UNIT                        LOAD   ACTIVE SUB     DESCRIPTION
  auditd.service              loaded active running Security Auditing Service
  chronyd.service             loaded active running NTP client/server
  crond.service               loaded active running Command Scheduler
  dbus.service                loaded active running D-Bus System Message Bus
  filebeat.service            loaded active running Filebeat sends log files to 
  gcstartup.service           loaded active exited  SYSV: Enterprise Manager Age
  getty@tty1.service          loaded active running Getty on tty1
  gssproxy.service            loaded active running GSSAPI Proxy Daemon
  irqbalance.service          loaded active running irqbalance daemon
  kdump.service               loaded active exited  Crash recovery kernel arming
  kmod-static-nodes.service   loaded active exited  Create list of required stat
  lockgcstartup.service       loaded active exited  SYSV: Enterprise Manager Age
  lvm2-lvmetad.service        loaded active running LVM2 metadata daemon
  lvm2-monitor.service        loaded active exited  Monitoring of LVM2 mirrors, 
  lvm2-pvscan@8:2.service     loaded active exited  LVM2 PV scan on device 8:2
  memcached.service           loaded active running Memcached
  monit.service               loaded active running Pro-active monitoring utilit
  network.service             loaded active exited  LSB: Bring up/down networkin
  NetworkManager-wait-online.service loaded active exited  Network Manager Wait Online
  NetworkManager.service      loaded active running Network Manager
  nginx.service               loaded active running The nginx HTTP and reverse p
  polkit.service              loaded active running Authorization Manager
  postgresql-11.service       loaded active running PostgreSQL 11 database serve
  redis.service               loaded active running Redis persistent key-value d
  rhel-dmesg.service          loaded active exited  Dump dmesg to /var/log/dmesg
  rhel-domainname.service     loaded active exited  Read and set NIS domainname 
  rhel-import-state.service   loaded active exited  Import network configuration
  rhel-readonly.service       loaded active exited  Configure read-only root sup
  rhsmcertd.service           loaded active running Enable periodic update of en
  rpcbind.service             loaded active running RPC bind service
  rsyslog.service             loaded active running System Logging Service
[1;31m●[0m [1;31msidekiq.service            [0m loaded [1;31mfailed failed [0m sidekiq
  snmpd.service               loaded active running Simple Network Management Pr
  sshd.service                loaded active running OpenSSH server daemon
  swiagentd.service           loaded active running SolarWinds Agent Service
  sysstat.service             loaded active exited  Resets System Activity Logs
  systemd-journal-flush.service loaded active exited  Flush Journal to Persistent 
  systemd-journald.service    loaded active running Journal Service
  systemd-logind.service      loaded active running Login Service
  systemd-random-seed.service loaded active exited  Load/Save Random Seed
  systemd-remount-fs.service  loaded active exited  Remount Root and Kernel File
  systemd-sysctl.service      loaded active exited  Apply Kernel Variables
  systemd-tmpfiles-setup-dev.service loaded active exited  Create Static Device Nodes i
  systemd-tmpfiles-setup.service loaded active exited  Create Volatile Files and Di
  systemd-udev-trigger.service loaded active exited  udev Coldplug all Devices
  systemd-udevd.service       loaded active running udev Kernel Device Manager
  systemd-update-utmp.service loaded active exited  Update UTMP about System Boo
  systemd-user-sessions.service loaded active exited  Permit User Sessions
  systemd-vconsole-setup.service loaded active exited  Setup Virtual Console
  tuned.service               loaded active running Dynamic System Tuning Daemon

LOAD   = Reflects whether the unit definition was properly loaded.
ACTIVE = The high-level unit activation state, i.e. generalization of SUB.
SUB    = The low-level unit activation state, values depend on unit type.

[1;39m50 loaded units listed.[0m Pass --all to see loaded but inactive units, too.
To show all installed unit files use 'systemctl list-unit-files'.
