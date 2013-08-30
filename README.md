puppet-artifactory
==================

Puppet module for managing Artifactory on Debian and Ubuntu.

# Installation #

Clone this repository in /etc/puppet/modules, but make sure you clone it as directory
'artifactory':

	cd /etc/puppet/modules
	git clone https://github.com/jurgenlust/puppet-artifactory.git artifactory

You also need the puppet-tomcat module:

	cd /etc/puppet/modules
	git clone https://github.com/jurgenlust/puppet-tomcat.git tomcat
	
You should also make sure the unzip package is installed, as well as a JDK.

	
# Usage #

The manifest in the tests directory shows how you can install Artifactory.
For convenience, a Vagrantfile was also added, which starts a
Debian Squeeze x64 VM and applies the init.pp. When the virtual machine is ready,
you should be able to access artifactory at
[http://localhost:8680/artifactory](http://localhost:8680/artifactory).

Note that the vagrant VM will only be provisioned correctly if the artifactory
and tomcat modules are in the same parent directory.


# Added functionality #

Artifactory can be configured through its REST API, but that only works for Pro version.
However, there are times an Artifactory needs to be when it is installed (aka provisioning).
This is where the added functionality kicks in; the added stuff is related to (mostly Maven
specific projects):

* manage local, remote or virtual repositories.
* manage backup policies.
* manage repository layouts. By default, the module will install some of the widely used
layouts: maven2, maven1, ivy and gradle.

**Warning** managing Artifactory's configuration through puppet will override any changes
achieved through web app. Make sure you either go one way, or the other!

So, here it is:

* creating a local repository:
    artifactory::repository::local { 'repo_x': }
    artifactory::repository::local { 'repo_y':
      description => 'store my artifacts',
      releases    => 'true',
      snapshots   => 'true',
    }

* creating a remote repository:
    artifactory::repository::remote { 'jboss':
      url => 'http://repository.jboss.org/nexus/content/groups/public-jboss',
      includes => 'org/jboss/**,org/hibernate/**,org/richfaces/**,org/drools/**',
    }

* creating a virtual repository:
    artifactory::repository::virtual { 'all':
      repositories_ref => [
        'repo_x', 'repo_y', 'central', 'jboss'
      ]
    }