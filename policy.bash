#!/bin/bash
#assuming all floor segments can ping to server subnet
#s0
#curl -X POST -d '{"firewall":"","src_address":"...../...","dst_address":"...../...","nw_proto":"TCP|UDP|ICMP","src_port":"...","dst_port":"...."}' http://localhost:8080/router/0000000000000003
S0=0000000000000001
S00=0000000000000002
S1=0000000000000003
S11=0000000000000004
S2=0000000000000005
S221=0000000000000006
S222=0000000000000007

gAP=0000000000000011
fAP=0000000000000012
sAP=0000000000000014
#groundfloor internal deny r_server, stu, office,display
curl -X POST -d  '{"firewall":"","src_address": "10.0.0.208/29", "dst_address": "10.0.0.0/26"}' http://localhost:8080/router/$S0
curl -X POST -d  '{"firewall":"","src_address": "10.0.0.208/29", "dst_address": "10.0.0.64/28"}' http://localhost:8080/router/$S0
curl -X POST -d  '{"firewall":"","src_address": "10.0.0.208/29", "dst_address": "10.0.0.128/27"}' http://localhost:8080/router/$S0
curl -X POST -d  '{"firewall":"","src_address": "10.0.0.208/29", "dst_address": "10.0.0.195"}' http://localhost:8080/router/$S0
curl -X POST -d  '{"firewall":"","src_address": "10.0.0.208/29", "dst_address": "10.0.0.64/28"}' http://localhost:8080/router/$S0

#demonstration deny r_server, stu, office, (present deny display)
curl -X POST -d  '{"firewall":"","src_address": "10.0.0.192/28", "dst_address": "10.0.0.128/27"}' http://localhost:8080/router/$S1
#curl -X POST -d  '{"firewall":"","src_address": "10.0.0.192/28", "dst_address": "10.0.0.168/29"}' http://localhost:8080/router/$S1
curl -X POST -d  '{"firewall":"","src_address": "10.0.0.192/28", "dst_address": "10.0.0.0/26"}' http://localhost:8080/router/$S1
curl -X POST -d  '{"firewall":"","src_address": "10.0.0.192/28", "dst_address": "10.0.0.64/28"}' http://localhost:8080/router/$S1
curl -X POST -d  '{"firewall":"","src_address": "10.0.0.194", "dst_address": "10.0.0.195"}' http://localhost:8080/router/$S00



#deny to internet 
curl -X POST -d  '{"firewall":"","src_address": "10.0.0.192/28", "dst_address": "11.11.11.0/30"}' http://localhost:8080/router/$S1

# S1
#r_server deny server(only IT and P&D)
curl -X POST -d  '{"firewall":"","src_address": "10.0.0.168/29", "dst_address": "10.0.0.128/27"}' http://localhost:8080/router/$S11

#S2 (office & instructure)
#office reach server, deny r_server&pc, lectern,present,display,stu

curl -X POST -d  '{"firewall":"","src_address": "10.0.0.64/28", "dst_address": "10.0.0.0/26"}' http://localhost:8080/router/$S2
curl -X POST -d  '{"firewall":"","src_address": "10.0.0.64/28", "dst_address": "10.0.0.128/27"}' http://localhost:8080/router/$S2
curl -X POST -d  '{"firewall":"","src_address": "10.0.0.64/28", "dst_address": "10.0.0.192/27"}' http://localhost:8080/router/$S2

#student
curl -X POST -d  '{"firewall":"","src_address": "10.0.0.0/26", "dst_address": "10.0.0.168/29"}' http://localhost:8080/router/$S2
curl -X POST -d  '{"firewall":"","src_address": "10.0.0.0/26", "dst_address": "10.0.0.128/27"}' http://localhost:8080/router/$S2
curl -X POST -d  '{"firewall":"","src_address": "10.0.0.0/26", "dst_address": "10.0.0.64/28"}' http://localhost:8080/router/$S2
curl -X POST -d  '{"firewall":"","src_address": "10.0.0.0/26", "dst_address": "10.0.0.192/27"}' http://localhost:8080/router/$S2
curl -X POST -d  '{"firewall":"","src_address": "10.0.0.0/26", "dst_address": "10.0.0.192/27"}' http://localhost:8080/router/$S2

#wireless
#groundfloor
	## guest
curl -X POST -d  '{"firewall":"","src_address": "172.16.0.0/26", "dst_address": "10.0.0.0/24"}' http://localhost:8080/router/$gAP
	## staff
curl -X POST -d  '{"firewall":"","src_address": "172.16.0.64/29", "dst_address": "10.0.0.0/25"}' http://localhost:8080/router/$gAP
curl -X POST -d  '{"firewall":"","src_address": "172.16.0.64/29", "dst_address": "10.0.0.192/27"}' http://localhost:8080/router/$gAP
curl -X POST -d  '{"firewall":"","src_address": "172.16.0.64/29", "dst_address": "10.0.0.128/27"}' http://localhost:8080/router/$gAP
curl -X POST -d  '{"firewall":"","src_address": "172.16.0.64/29", "dst_address": "10.0.0.160/29"}' http://localhost:8080/router/$gAP
curl -X POST -d  '{"firewall":"","src_address": "172.16.0.64/29", "dst_address": "172.16.1.0/26"}' http://localhost:8080/router/$gAP
curl -X POST -d  '{"firewall":"","src_address": "172.16.0.64/29", "dst_address": "172.16.0.128/25"}' http://localhost:8080/router/$gAP

#second floor 
	#student
curl -X POST -d  '{"firewall":"","src_address": "172.16.0.128/26", "dst_address": "172.16.1.0/26"}' http://localhost:8080/router/$sAP
curl -X POST -d  '{"firewall":"","src_address": "172.16.0.128/26", "dst_address": "10.0.0.64/28"}' http://localhost:8080/router/$sAP
curl -X POST -d  '{"firewall":"","src_address": "172.16.0.128/26", "dst_address": "10.0.0.192/27"}' http://localhost:8080/router/$sAP
curl -X POST -d  '{"firewall":"","src_address": "172.16.0.128/26", "dst_address": "10.0.0.128/27"}' http://localhost:8080/router/$sAP
curl -X POST -d  '{"firewall":"","src_address": "172.16.0.128/26", "dst_address": "10.0.0.160/29"}' http://localhost:8080/router/$sAP

	## staff
curl -X POST -d  '{"firewall":"","src_address": "172.16.0.192/28", "dst_address": "10.0.0.128/27"}' http://localhost:8080/router/$sAP


