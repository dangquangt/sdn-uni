#!/bin/bash

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
ISP=0000000000000008

#### S00 Assign address (Links General flor, S0) 
 
echo -e 'Assigning address S00\n'
curl -X POST -d '{"address":"10.0.0.226/30"}' http://localhost:8080/router/$S00
curl -X POST -d '{"address":"10.0.0.193/28"}' http://localhost:8080/router/$S00
curl -X POST -d '{"address":"10.0.0.209/29"}' http://localhost:8080/router/$S00 
curl -X POST -d '{"address":"172.16.0.73/30"}' http://localhost:8080/router/$S00
echo ""
### Ground AP Assign Address 
echo -e '\n Assigning address Ground floor AP 0\n'
echo ""
curl -X POST -d '{"address":"172.16.0.1/26"}' http://localhost:8080/router/$gAP
curl -X POST -d '{"address":"172.16.0.65/29"}' http://localhost:8080/router/$gAP
curl -X POST -d '{"address":"172.16.0.74/30"}' http://localhost:8080/router/$gAP


### S0 Assign address (Links S1, S00) 

echo -e '\n Assigning address S0\n'
curl -X POST -d '{"address":"10.0.0.225/30"}' http://localhost:8080/router/$S0
curl -X POST -d '{"address":"10.0.0.242/30"}' http://localhost:8080/router/$S0

## S1 Assign address (Links S0, S11, S2) 
echo ""
echo -e '\n Assigning address S1\n'
curl -X POST -d '{"address":"10.0.0.241/30"}' http://localhost:8080/router/$S1 
curl -X POST -d '{"address":"10.0.0.229/30"}' http://localhost:8080/router/$S1
curl -X POST -d '{"address":"10.0.0.245/30"}' http://localhost:8080/router/$S1
curl -X POST -d '{"address":"11.11.11.2/30"}' http://localhost:8080/router/$S1

### S11 Assign address (Links S1, Firstfloor)
echo ""
echo -e '\n Assigning address S11\n'
curl -X POST -d '{"address":"10.0.0.230/30"}' http://localhost:8080/router/$S11
curl -X POST -d '{"address":"10.0.0.161/29"}' http://localhost:8080/router/$S11
curl -X POST -d '{"address":"10.0.0.129/27"}' http://localhost:8080/router/$S11
curl -X POST -d '{"address":"10.0.0.169/29"}' http://localhost:8080/router/$S11
curl -X POST -d '{"address":"172.16.1.33/30"}' http://localhost:8080/router/$S11

### first floor AP assign 
echo ""
echo -e '\n Assigning address first floor AP \n'
curl -X POST -d '{"address":"172.16.1.1/27"}' http://localhost:8080/router/$fAP
curl -X POST -d '{"address":"172.16.1.34/30"}' http://localhost:8080/router/$fAP

## S2  Assign address (Links S221, S222, S1)
echo ""
echo -e '\n Assigning address S2\n'
curl -X POST -d '{"address":"10.0.0.246/30"}' http://localhost:8080/router/$S2
curl -X POST -d '{"address":"10.0.0.233/30"}' http://localhost:8080/router/$S2
curl -X POST -d '{"address":"10.0.0.237/30"}' http://localhost:8080/router/$S2
curl -X POST -d '{"address":"172.16.0.209/30"}' http://localhost:8080/router/$S2

### Second AP Assign Address 
curl -X POST -d '{"address":"172.16.0.129/26"}' http://localhost:8080/router/$sAP
curl -X POST -d '{"address":"172.16.0.193/28"}' http://localhost:8080/router/$sAP
curl -X POST -d '{"address":"172.16.0.210/30"}' http://localhost:8080/router/$sAP

### S221 Assign address (Links S2,Office)
echo ""
echo -e '\n Assigning address S221\n'
curl -X POST -d '{"address":"10.0.0.65/28"}' http://localhost:8080/router/$S221
curl -X POST -d '{"address":"10.0.0.234/30"}' http://localhost:8080/router/$S221

### S222 Assign address (Links S2, Lab) 
echo ""
echo -e '\n Assigning address S222\n'
curl -X POST -d '{"address":"10.0.0.1/26"}' http://localhost:8080/router/$S222
curl -X POST -d '{"address":"10.0.0.238/30"}' http://localhost:8080/router/$S222

### ISP 
curl -X POST -d '{"address":"11.11.11.1/30"}' http://localhost:8080/router/$ISP

########### ROUTES
## S00

echo -e 'Setting up link S00\n'

curl -X POST -d '{"gateway": "10.0.0.225"}' http://localhost:8080/router/$S00
curl -X POST -d '{"destination":"172.16.0.0/26","gateway": "172.16.0.74"}' http://localhost:8080/router/$S00
curl -X POST -d '{"destination":"172.16.0.64/29","gateway": "172.16.0.74"}' http://localhost:8080/router/$S00
## gAP 
curl -X POST -d '{"gateway": "172.16.0.73"}' http://localhost:8080/router/$gAP

echo -e '\nSetting up link S0\n'
## S0 
	### ROUTE BACK to S00 
curl -X POST -d '{"destination":"10.0.0.193/28","gateway": "10.0.0.226"}' http://localhost:8080/router/$S0
curl -X POST -d '{"destination":"10.0.0.209/29","gateway": "10.0.0.226"}' http://localhost:8080/router/$S0
curl -X POST -d '{"destination":"172.16.0.0/26","gateway": "10.0.0.226"}' http://localhost:8080/router/$S0
curl -X POST -d '{"destination":"172.16.0.64/29","gateway": "10.0.0.226"}' http://localhost:8080/router/$S0
	
	### ROUTE BACK To S11
curl -X POST -d '{"destination":"10.0.0.160/29","gateway":"10.0.0.241"}' http://localhost:8080/router/$S0
curl -X POST -d '{"destination":"10.0.0.128/27","gateway":"10.0.0.241"}' http://localhost:8080/router/$S0
curl -X POST -d '{"destination":"10.0.0.168/29","gateway":"10.0.0.241"}' http://localhost:8080/router/$S0

	### ROUTE BACK to S221
curl -X POST -d '{"destination":"10.0.0.64/28","gateway": "10.0.0.241"}' http://localhost:8080/router/$S0
curl -X POST -d '{"destination":"10.0.0.0/26","gateway": "10.0.0.241"}' http://localhost:8080/router/$S0

	### ROUTE BACK to S222
curl -X POST -d '{"destination":"10.0.0.236/30","gateway": "10.0.0.241"}' http://localhost:8080/router/$S0
curl -X POST -d '{"destination":"10.0.0.244/30","gateway": "10.0.0.241"}' http://localhost:8080/router/$S0

	### Internet only 
curl -X POST -d '{"gateway": "10.0.0.241"}' http://localhost:8080/router/$S0


echo -e '\nSetting up link S11\n'
## S11
curl -X POST -d '{"gateway": "10.0.0.229"}' http://localhost:8080/router/$S11
curl -X POST -d '{"destination":"10.0.0.192/28","gateway": "10.0.0.229"}' http://localhost:8080/router/$S11
curl -X POST -d '{"destination":"10.0.0.208/29","gateway": "10.0.0.229"}' http://localhost:8080/router/$S11
curl -X POST -d '{"destination":"172.16.1.0/27","gateway": "172.16.1.34"}' http://localhost:8080/router/$S11


## fAP 
curl -X POST -d '{"gateway": "172.16.1.33"}' http://localhost:8080/router/$fAP

echo -e 'Setting up link S1\n'
## S1
	### ISP
curl -X POST -d '{"gateway": "11.11.11.1"}' http://localhost:8080/router/$S1
	
	### ROUTE BACK To S00
curl -X POST -d '{"destination":"10.0.0.192/28","gateway": "10.0.0.242"}' http://localhost:8080/router/$S1
curl -X POST -d '{"destination":"10.0.0.208/29","gateway": "10.0.0.242"}' http://localhost:8080/router/$S1
curl -X POST -d '{"destination":"172.16.0.0/26","gateway": "10.0.0.242"}' http://localhost:8080/router/$S1
curl -X POST -d '{"destination":"172.16.0.64/29","gateway": "10.0.0.242"}' http://localhost:8080/router/$S1
	
	### ROUTE BACK To S11
curl -X POST -d '{"destination":"10.0.0.128/27","gateway":"10.0.0.230"}' http://localhost:8080/router/$S1
curl -X POST -d '{"destination":"10.0.0.160/29","gateway":"10.0.0.230"}' http://localhost:8080/router/$S1
curl -X POST -d '{"destination":"10.0.0.168/29","gateway":"10.0.0.230"}' http://localhost:8080/router/$S1
curl -X POST -d '{"destination":"172.16.1.0/27","gateway": "10.0.0.230"}' http://localhost:8080/router/$S1

	### ROUTE TO 221
curl -X POST -d '{"destination":"10.0.0.64/28","gateway": "10.0.0.246"}' http://localhost:8080/router/$S1
curl -X POST -d '{"destination":"10.0.0.0/26","gateway": "10.0.0.246"}' http://localhost:8080/router/$S1

	### ROUTE TO 222
curl -X POST -d '{"destination":"10.0.0.232/30","gateway": "10.0.0.246"}' http://localhost:8080/router/$S1
curl -X POST -d '{"destination":"10.0.0.236/30","gateway": "10.0.0.246"}' http://localhost:8080/router/$S1

	### ROUTE TO S2
curl -X POST -d '{"destination":"172.16.0.128/26","gateway": "10.0.0.246"}' http://localhost:8080/router/$S1
curl -X POST -d '{"destination":"172.16.0.192/28","gateway": "10.0.0.246"}' http://localhost:8080/router/$S1


## S221
curl -X POST -d '{"gateway": "10.0.0.233"}' http://localhost:8080/router/$S221

## S222
curl -X POST -d '{"gateway": "10.0.0.237"}' http://localhost:8080/router/$S222

## sAP 
curl -X POST -d '{"gateway": "172.16.0.209"}' http://localhost:8080/router/$sAP

## S2
curl -X POST -d '{"gateway": "10.0.0.245"}' http://localhost:8080/router/$S2
curl -X POST -d '{"destination":"10.0.0.64/28","gateway": "10.0.0.234"}' http://localhost:8080/router/$S2
curl -X POST -d '{"destination":"10.0.0.0/26","gateway": "10.0.0.238"}' http://localhost:8080/router/$S2
curl -X POST -d '{"destination":"172.16.0.128/26","gateway": "172.16.0.210"}' http://localhost:8080/router/$S2
curl -X POST -d '{"destination":"172.16.0.192/28","gateway": "172.16.0.210"}' http://localhost:8080/router/$S2

## ISP 
curl -X POST -d '{"gateway": "11.11.11.2"}' http://localhost:8080/router/$ISP	
	
	
	
