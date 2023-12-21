Role Purpose
=========

The "new_relic" Ansible role is designed to automate the deployment and configuration of the New Relic Infrastructure Agent on target servers. New Relic Infrastructure provides real-time insights into server performance, infrastructure monitoring, and the collection of server data for analysis.

Role Variables
--------------

Before running the role on your target servers, users need to specify the license key,agent version and target architecture as playbook extra variables for customization based on the user's requirement. 


How to use the role
----------------

To install the playbook for specific version you can run using the following command:
ansible-playbook playbook/my_playbook.yml --tags=version_specific -e "version=1.27.4 arch=amd64 license=YOUR_LICENSE_KEY"

This command can install new relic for debian and ubuntu distribution.
NOTE: The version and arch depends on your version choice and your system's architecture.

To uninstall new relic:
ansible-playbook playbook/my_playbook.yml --tags=uninstall

License Key 
-------

You can find your new relic license key in yourProfile --> API Keys --> Original account license Key


