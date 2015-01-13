[supervisord]
nodaemon=true

[program:nuoagent]
command=sudo service nuoagent start
autostart=${NUOAGENT_START}

[program:nuorestsvc]
command=sudo service nuorestsvc start
autostart=${NUORESTSVC_START}

[program:nuowebconsole]
command=sudo service nuowebconsole start
autostart=${NUOWEBCONSOLE_START}
