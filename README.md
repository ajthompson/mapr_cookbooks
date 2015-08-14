#mapr deployments


This repository contains a few different options for deploying MapR Hadoop clusters.  The one furthest along is orchestrated by Fabric, and uses Chef on each node to execute the deployment.

##Assumptions

* A user on each node, allowing ssh and sudo
* Berkshelf Ruby gem installed on packaging machine
  * In base folder of this repo, touch a file called 'DEV' to activate development mode, or remove file to deactivate development mode

##Process

###Prepare

    ./package
Copy the tarball somewhere, and expand it.

###Edit

In the packaged folder (from the tarball above), edit cluster.json.example to suit your cluster, and rename it to cluster.json.

###Execute

    ./install

###Manual Steps

These steps currently need to be completed manually after running the install script:

1. Before starting services, issue ```sudo passwd mapr```
2. Start Zookeepers on all nodes ```sudo /etc/init.d/mapr-zookeeper start```
3. Start Warden on all nodes ```sudo /etc/init.d/mapr-warden start```
4. Set MapR user ```/opt/mapr/bin/maprcli acl edit -type cluster -user <user>:fc```
5. Hit ```https://<webserver-node-hostname>:8443/``` and get on with Hadooping

Finally, if MapR 3.1, 3.1.1, 4.0.0, or 4.0.1 was installed, a patch must be applied to fix an SSL certificate bug and allow the webserver to be accessible.
(http://doc.mapr.com/display/RelNotes/MapR+Control+System+Certificate+Issue)

1. Determine which nodes in the cluster run the webserver role.

    ```maprcli node list -columns configuredservice -filter '[configuredservice==webserver]'```

2. Perform the following command on each webserver node, after mapr-warden has been started: 

    ```
    wget http://package.mapr.com/scripts/mcs/fixssl; 
    chmod 755 fixssl; 
    sudo ./fixssl;
    ```


## TODO

* delete everything from this chef repo that fabric doesn't move over
* generate new certificates each run
* .bashrc for install user and mapr user, not just root
* json parse check on cluster.json before executing anything fabric or manifests.py related.
* start zk, wait for success, then start cldb (warden), wait for success, then start warden on other nodes
* add 'fc' permissions to mapr user
* install clush on installer node, with proper groups & sudo
* passwd on mapr user (only webserver?  or all nodes?)
* sshd_config ... add mapr to AllowGroups
* one zk setup - should be single and not stand-alone, for easier migrations to multiple zks... but not an even number.
* Metrics setup
* finish off local package repository functionality - installer or other node holds all packages for other nodes to pull - bandwidth saver
* disksetup - make idempotent
* add nodes to existing cluster
* Web UI
