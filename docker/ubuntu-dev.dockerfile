FROM --platform=arm64 ubuntu:latest

RUN apt update && apt install openssh-server sudo git vim make -y

# install node 18.x(LTS)
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - && sudo apt-get install -y nodejs

RUN echo "export PS1='[\[\e[32m\]\u@\[\e[36m\]\h \[\e[35m\]\W\[\e[37m\]:\[\e[31m\]\#\[\e[0m\]]\$ \n>> '" >> /root/.bashrc

# add init git ssh config
RUN echo '#!/bin/bash
mkdir -p /root/.ssh && cp /root/ssh-host/id_rsa_ob /root/.ssh/ && cp /root/ssh-host/id_rsa_ob.pub /root/.ssh/ && cp /root/ssh-host/config /root/.ssh/' > /root/init-git-ssh.sh
RUN chmod u+x /root/init-git-ssh.sh

RUN mkdir -p /root/.ssh && touch /root/.ssh/authorized_keys && echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDIjZHyqhN/+9WrXd2q3hrAz9bFnlzj3cwBQxhWz1vjMsDi+IAGtDj1iWBR6umg1VEVvmGcMMNl5wD3v71+/E14RNAmtWo8MBGHvl3buM1jUGWA52T6fc93W32yW88/6FpPV/exYLj5OfGXVLwtMFAeAbp3yhFMdYgT+jPts9HDTuxRbo3ltpC3viLEoziZirphXVpePiafXyIpahMQ6m2HqEJMiXfv8GAgsliwZ73cfbN+593qINV2uEYO60WiMjFFPLmEAysFHNgf1hw0QjBQMsdg7e6c4WlR1WrPotW+K3ChqXyw73U4+Cs0lOkbC1HE4aRyg1pEgF0bgpFXKiwLhMb/fnI0TeEf3PPrg4PDsaRmOWyX3xGy3PfMiYevVVNmrNtuL+LJg1y+lfJOrtkKIkvtEoEeS2qv7wJFug+5HUKQVP/JvREKU9W+vgNmX4Jite0nYq9jZNwlT/Tli1Nys06sWTaOcc6lCMVno/XAo2Tpn8bl35NQOjYtGID+UnU= edony@B-1V73X3RW-0109.local" >> /root/.ssh/authorized_keys

RUN echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config

RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

RUN ssh-keygen -A

RUN echo 'root:test' | chpasswd

RUN service ssh start

EXPOSE 22

CMD ["/usr/sbin/sshd","-D"]
