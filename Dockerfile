FROM ubuntu:14.04

#libgssapi libkrb53 libgssapi-krb5-2
RUN apt-get update && \
    apt-get install -y libgssapi-krb5-2 --reinstall

ENV jasperVersion 6.1.0

ADD http://netcologne.dl.sourceforge.net/project/jasperserver/JasperServer/JasperReports%20Server%20Community%20Edition%20${jasperVersion}/jasperreports-server-cp-${jasperVersion}-linux-x64-installer.run /home/root/

RUN chmod +x /home/root/jasperreports-server-cp-${jasperVersion}-linux-x64-installer.run

RUN /home/root/jasperreports-server-cp-${jasperVersion}-linux-x64-installer.run --mode unattended --postgres_password Password1

COPY check.sh /home/root/
RUN chmod +x /home/root/check.sh

WORKDIR /opt/jasperreports-server-cp-${jasperVersion}

EXPOSE 8080

CMD sh ctlscript.sh start && /home/root/check.sh