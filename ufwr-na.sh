#!/bin/zsh

# If not root, break and require root
if [ `whoami` != root ]; then
  echo Script requires root to run
  exit
fi

# Flush old rules
iptables -F

### Firewall rules ###

iptables -A INPUT -p icmp -j ACCEPT
iptables -A OUTPUT -p icmp -j ACCEPT

#____SERVER RULES
#___Web___
iptables -A INPUT -p TCP --dport 80 -j ACCEPT
iptables -A OUTPUT -p TCP --sport 80 -j ACCEPT
iptables -A INPUT -p TCP --dport 443 -j ACCEPT
iptables -A OUTPUT -p TCP --sport 443 -j ACCEPT

#___SSH___
iptables -A INPUT -p TCP --dport 22 -j ACCEPT
iptables -A OUTPUT -p TCP --sport 22 -j ACCEPT

#___Loopback___
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT


#____Client Rules____

#__SQL__
iptables -A INPUT -p TCP --sport 1433 -j ACCEPT
iptables -A OUTPUT -p TCP --dport 1433 -j ACCEPT

#__Web__
iptables -A INPUT -p TCP --sport 80 -j ACCEPT
iptables -A OUTPUT -p TCP --dport 80 -j ACCEPT
iptables -A INPUT -p TCP --sport 443 -j ACCEPT
iptables -A OUTPUT -p TCP --dport 443 -j ACCEPT

#__DNS__
iptables -A INPUT -p UDP --sport 53 -j ACCEPT
iptables -A OUTPUT -p UDP --dport 53 -j ACCEPT

#___Drop everything else___
iptables -A INPUT -j DROP
iptables -A OUTPUT -j DROP
