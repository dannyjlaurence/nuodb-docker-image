#
# The default agent properties. To use a different source of properties set
# the system property "propertiesUrl" to the URL of a properties file:
#
#   java -DpropertiesUrl=URL nuoagent.jar ...
#
# The default values for each property are shown in this file. All addresses
# can optionally include a port number using the syntax host:port.
#
# Note that all of these properties are optional, except for the domain
# password. A default value is assigned to this. Domain administrators should
# pick a new password to secure their domains.
#
# 2.0 History:
#
# 2.0.1
#   "metricsPurgeAge", "eventsPurgeAge" added
# 2.0.2
#   "automationTemplate" added
# 2.0.3
#   "automationTemplate": Once the admin db has been created during bootstrap,
#       use Auto Console UI to edit the admin db's template. The bootstrap
#       process will no longer upgrade the template as it did in 2.0.2
#   "peer" supports comma-separated list of peers
# 2.0.4
#   "agentPeerTimeout", "hostTags" added (optional)
#   "singleHostDbRestart" added, default TRUE

# A flag specifying whether this agent should be run as a connection broker
broker = ${BROKER}

# The name used to identify the domain that this agent is a part of 
domain = ${DOMAIN_USER}

# The default administrative password, and the secret used by agents to
# setup and maintain the domain securely
domainPassword = ${DOMAIN_PASSWORD}

# The port that this agent listens on for all incoming connections
port = ${AGENT_PORT}

# A range of port numbers that nuodb instances should be confined to. This is
# of the form start[,end].  Note: Specifying a start without an end indicates
# that process TCP/IP ports are assigned incrementally from the start without
# limit
# 
# Each new process (transaction engine or storage manager) that is started on a
# machine is communicated with via an assigned TCP/IP port that is specified
# via this property.  Ensure firewall rules allow access from other machines.
portRange = ${NEW_PROCESS_PORT_RANGE}

# An existing peer (agent or broker) already running in the domain that this
# agent should connect to on startup to extend the running domain.
# 2.0.3 or later support a comma-separated list of peers
${PEERS}

# An alternate address to use in identifying this host, which is not actually
# advertised unless the advertiseAlt property is set.
${BROKER_ALT_ADDR}

# A flag specifying whether the alternate address should be advertised instead
# of the locally observed network addresses. This is only meaningful for
# brokers, because only brokers advertise addresses to clients and admins.
${ADVERTISE_ALT}

# The region for this host. The region of a host should not be changed after it
# has been set.
${REGION}
    
# The log level for the agent log output. Valid levels are, from most to least 
# verbose: ALL, FINEST, FINER, FINE, CONFIG, INFO, WARNING, SEVERE, OFF
${LOG_LEVEL}

# The location of the directory with the 'nuodb' executable, which is typically
# the same as the directory where the nuoagent.jar file is found
#binDir = .

# A flag specifying whether this host has automation enabled and should attempt
# to access the NuoDB "nuodb_system" admin database
enableAutomation = ${AUTOMATION}

# A flag indicating that a Broker should auto-start the NuoDB "nuodb_system"
# admin database / TE
enableAutomationBootstrap = ${AUTOMATION_BOOTSTRAP}

# A flag specifying whether host level statistics should be collected using
# sigar. The default is inferred from the property "enableAutomation"
enableHostStats = true

# The interval (in seconds) that brokers should wait between sending out UDP
# broadcast messages for local discovery, and that agents should wait to hear
# those messages on startup. By default broadcast is turned off so peering
# is done using the 'peer' property.
#broadcast = 0

# A flag specifying whether nuodb instances can only be started through this
# agent (as opposed to directly starting a nuodb process on the system). If this
# flag is true then a "connection key" is required of all nuodb instances. A
# connection key is only available if the process was started through a request
# on the agent. This is a good best-practice flag for locking down a system.
#requireConnectKey = false

# A flag specifying the SQL connection load balancer that this broker should 
# use. The balancer determines how the broker chooses to which TE a SQL 
# connection is routed. This property has no effect on an agent.
#
# Set this property to "RegionBalancer" to enable a policy where SQL clients
# are connected to TEs in this Broker's region in a round-robin pattern. If
# no TEs are present in this broker's region then connections will be routed
# to TEs in any region in a round-robin pattern.
#balancer =

# ADDED in 2.0.1 #

# When "enableAutomation" is set, prune metrics by age. Default is 4 hours: 4h
# Supported Units are d=day, h=hour, m=minute.
#metricsPurgeAge =

# When "enableAutomation" is set, prune events by age. Default is 7 days: 7d
#eventsPurgeAge =

# ADDED in 2.0.2 #

# If enableAutomationBootstrap is enabled, then use this template to enforce
# the NuoDB "nuodb_system" admin database.
# REVISED in 2.0.3:
# Once admin db is created during bootstrap, use Auto Console UI to edit
# the admin db's template.
#automationTemplate = Single Host

# ADDED in 2.0.4 #

# By default, an Agent will shutdown when the peer attempt failed. By setting
# this property, the Agent will continue to try to entry peer, until the timeout
# in milliseconds has been reached. To preserve backward compatibility, the default
# is to not retry. Note that this option is not related to Agent reconnect when
# its peer Broker disconnects; this option is only for the initial entry into the
# domain.
#agentPeerTimeout = -1

# This property enables auto-restart of single host databases. The Broker
# writes a marker file into the varDir (e.g. /var/opt/nuodb1/demo-archives/)
# when a database starts up. On machine / Broker restart, the broker starts
# any database for which a marker exists. A database shutdown command will
# remove the marker. Only applicable for "un-managed" databases not governed
# by Automation.
# Code default is false, to preserve backward compatibilty
# singleHostDbRestart = false
singleHostDbRestart = true

# Set this property to inject additional Host Tags into the Agent's TagService.
# Well-defined host tags that are injected by default such as "osversion", "region"
# can not be overwritten and will be ignored. The format is a comma-separated list
# of key=value pairs, with each string token being trimmed.
# Example: hostTags = tag1 = val, tag2=v2  
#hostTags =