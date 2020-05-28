#!/usr/bin/python
from mininet.net import Mininet
from mininet.node import Controller, OVSKernelSwitch, Host
from mininet.link import TCLink
from mininet.log import setLogLevel, info
from mininet.cli import CLI
from mininet.topo import Topo
# from mn_wifi.topo import Topo
from mn_wifi.net import Mininet_wifi
from mn_wifi.node import OVSKernelAP
from mn_wifi.cli import CLI


def int2dpid(dpid):
    try:
        dpid = hex(dpid)[2:]
        dpid = '0' * (16 - len(dpid)) + dpid
        return dpid
    except IndexError:
        raise Exception('Unable to derive default datapath ID - '
                        'please either specify a dpid or use a '
                        'canonical switch name such as s23.')


def create_Topo():
    ### Add Host
    # Groundfloor
    # General
    net = Mininet_wifi(topo=None)
    c0 = net.addController('c0', controller=Controller,
                           protocol='tcp',
                           port=6633)

    gAP = net.addAccessPoint('ap0', cls=OVSKernelAP, dpid=int2dpid(17), ssid='ap1-ssid',
                             channel='1', mode='g', position='40.0,30.0,0')
    info("***Add host \n")
    # Reception
    rec = net.addHost('rec', ip='10.0.0.210/29', defaultRoute='via 10.0.0.209')
    gsta = net.addStation('gsta', ip='172.16.0.2/26', defaultRoute='via 172.16.0.1', position='50.0,37.0,0')
    sta_rec = net.addStation('recsta', ip='172.16.0.67/29', defaultRoute='via 172.16.0.65',position='35.0,40.0,0')
    # Demonstration
    present = net.addHost('present', ip='10.0.0.194/28', defaultRoute='via 10.0.0.193')
    display = net.addHost('display', ip='10.0.0.195/28', defaultRoute='via 10.0.0.193')
    lectern = net.addHost('lectern', ip='10.0.0.211/29', defaultRoute='via 10.0.0.209')
    sw_list = []

    # 1st floor
    fAP = net.addAccessPoint('ap2', cls=OVSKernelAP, dpid=int2dpid(18), ssid='ap2-ssid',
                             channel='5', mode='g', position='60.0,50.0,0')
    fsta = net.addStation('fsta', ip='172.16.1.2/27', defaultRoute='via 172.16.1.1', position='58.0,59.0,0')
    # Server room
    server = net.addHost('server', ip='10.0.0.170/29', defaultRoute='via 10.0.0.169')
    r_server = net.addHost('r_server', ip='10.0.0.130/27', defaultRoute='via 10.0.0.129')
    # IT room
    it = net.addHost('it', ip='10.0.0.162/29', defaultRoute='via 10.0.0.161')
    # Research & Prototyping lab
    r_pc = net.addHost('r_pc', ip='10.0.0.131/27', defaultRoute='via 10.0.0.129')

    # 2nd floor
    # sAP=net.addAccessPoint('ap2')
    sAP = net.addAccessPoint('ap3', cls=OVSKernelAP, dpid=int2dpid(20), ssid='ap2-ssid',
                             channel='5', mode='g', position='40.0,90.0,0')
    ssta = net.addStation('ssta', ip='172.16.0.130/26', defaultRoute='via 172.16.0.129', position='38.0,80.0,0')
    sta_office = net.addStation('officesta', ip='172.16.0.194/28', defaultRoute='via 172.16.0.193', position='38.0,80.0,0')
    # Five offices

    office = net.addHost('office', ip='10.0.0.66/28', defaultRoute='via 10.0.0.65')
    # Seminar room
    instru = net.addHost('instru', ip='10.0.0.67/28', defaultRoute='via 10.0.0.65')
    stu = net.addHost('stu', ip='10.0.0.2/26', defaultRoute='via 10.0.0.1')

    # add switch
    info("***Add switch \n")
    s0 = net.addSwitch('s0', cls=OVSKernelSwitch, dpid=int2dpid(1))
    s00 = net.addSwitch('s00', cls=OVSKernelSwitch, dpid=int2dpid(2))
    s1 = net.addSwitch('s1', cls=OVSKernelSwitch, dpid=int2dpid(3))
    s11 = net.addSwitch('s11', cls=OVSKernelSwitch, dpid=int2dpid(4))
    s2 = net.addSwitch('s2', cls=OVSKernelSwitch, dpid=int2dpid(5))
    s221 = net.addSwitch('s221', cls=OVSKernelSwitch, dpid=int2dpid(6))
    s222 = net.addSwitch('s222', cls=OVSKernelSwitch, dpid=int2dpid(7))
    isp = net.addSwitch('isp', cls=OVSKernelSwitch, dpid=int2dpid(8))

    info("***Setting up wifi node\n")
    net.configureWifiNodes()
    info("*** Configuring Propagation Model\n")
    net.setPropagationModel(model="logDistance", exp=3)

    # addlink
    info("***Setting up links\n")
    ## ground floor
    net.addLink(s00, s0)
    net.addLink(s00, rec)

    net.addLink(s00, present)
    net.addLink(s00, display)
    net.addLink(s00, lectern)
    net.addLink(s00, gAP)

    net.addLink(sta_rec, gAP)
    net.addLink(gsta, gAP)


    # addlink:
    net.addLink(s0, s1)

    ## first floor
    net.addLink(s1, s11)

    # net.addLink(s1,fAP,3,0,params1={'ip':'10.0.0.162/27'},params2={'ip':'10.0.0.161/27'})

    net.addLink(s11, server)
    net.addLink(s11, r_server)
    net.addLink(s11, it)
    net.addLink(s11, r_pc)

    net.addLink(s11,fAP)
    net.addLink(fsta, fAP)

    net.addLink(s1, isp)



    # addlink:
    net.addLink(s1, s2)
    ## Second floor
    net.addLink(s2, s221)

    net.addLink(s2, s222)

    net.addLink(s221, office)
    net.addLink(s221, instru)

    net.addLink(s222, stu)

    net.addLink(s2, sAP)
    net.addLink(ssta, sAP)
    net.addLink(sta_office, sAP)


    "*** Starting network"
    net.build()
    c0.start()
    gAP.start([c0])
    fAP.start([c0])
    sAP.start([c0])

    net.get('s2').start([c0])
    net.get('s1').start([c0])
    net.get('s221').start([c0])
    net.get('s222').start([c0])
    net.get('s11').start([c0])
    net.get('s0').start([c0])
    net.get('s00').start([c0])
    net.get('isp').start([c0])


    ## plot graph
    net.plotGraph(max_x=100, max_y=100)
    "*** Running CLI"
    CLI(net)

    print
    "*** Stopping network"
    net.stop()


if __name__ == '__main__':
    setLogLevel('info')
    create_Topo()