#!/bin/bash

r=/etc/ipf/ipf.conf

# Firewall Rules File
cat > /etc/rc.conf << EOF
ipfilter_enable="YES"
ipfilter_rules="$r"
ipmon_enables="YES"
ipmon_flags="-Ds"
EOF

# Firewall Config File
cat > $r << EOF
pass in quick log proto icmp from any to any
pass out quick log proto icmp from any to any
pass out quick log proto tcp from any to any port = 22 keep state
pass in quick log proto tcp from any port = 22 to any keep state
block out all
block in all
EOF
# Start Firewall
ipf -Fa -f $r
svcadm enable network/ipfilter
svcadm refresh network/ipfilter
ipf -E
