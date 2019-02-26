# JBCS-729
reproducer for JBCS-729
use 3 tomcats (tc1, tc2, tc3) 3 webapps
examples1, examples2, examples3) configured to use mod_cluster
start them and Apache httpd with mod_cluster
check Mod_cluster Status for the 3 tomcats are seen by httpd and in OK state.
start the test.sh and wait....
