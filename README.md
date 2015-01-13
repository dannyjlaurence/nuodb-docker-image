Docker NuoDB Image
============

Thanks to @kakawait, and https://github.com/kakawait/docker-nuodb

This is a docker file image of NuoDB 2.1.1.5. It can be found at https://registry.hub.docker.com/u/dannyjlaurence/nuodb/

Learn more about NuoDB from http://www.nuodb.com/ 

# QuickStart

The first thing needed is to download the NuoDB 2.1.1.5 debian image from http://www.nuodb.com/ and place it in the root of this directory. Please leave the name as nuodb_2.1.1.5.deb

You just want to start a NuoDB instance and see how awesome it is. I get it. All you need to do is install get Docker all set up (http://docs.docker.com/installation/#installation), and run the following command: 
```bash
docker run -d -p 48004:48004 -p 48005:48005 -p 48006:48006 -p 8888:8888 -p 9001:9001 dannyjlaurence/nuodb
```
You should then be able to go to {dockerhost}:8888/, and see the NuoDB welcome screen. To start to play around, go to the top corner, click "automation console", and log in with the default domain credentials domain/bird. 

# Configurations

The Dockerfile contains the following variables:
```Dockerfile
ENV DOMAIN_USER domain
ENV DOMAIN_PASSWORD bird

ENV NUODB_HOME /opt/nuodb
ENV BROKER true
ENV AGENT_PORT 48004
ENV NEW_PROCESS_PORT_RANGE 48005
ENV AUTOMATION false
ENV AUTOMATION_BOOTSTRAP false
ENV LOG_LEVEL log = INFO

ENV BROKER_ALT_ADDR #altAddr = different ip here
ENV ADVERTISE_ALT #advertiseAlt = true
ENV REGION #region = 

ENV NUOAGENT_START true
ENV NUORESTSVC_START true
ENV NUOWEBCONSOLE_START true
```
Most are self expantory, and if not, you can take a look at the default.properties.tpl to get a pretty lengthy discussion of the NuoDB enviornment variables. Not all are exposed here and perhaps soon I will expose all of them.

The AGENT_PORT variable tells NuoDB what port to look for other brokers on. Thus, if you want to use a non-standard port, you'll have to not only change the envorinment variable, but also map that port in the docker container (ie: -p 8080:8080 if you wanted 8080 to be the port the brokers communicate on).

Of note, the BROKER_ALT_ADDR, ADVERTISE_ALT, and REGION variables currently need to be used as a whole line (you notice they are commented out). This is because these values don't take empty or blank, they are either commented out, or have a value. 

The *_START variables set supervisor to start those respected services automatically or not. You may not want to start the web console or rest services, just have a broker. 