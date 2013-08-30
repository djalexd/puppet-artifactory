#
# Defines a virtual repository, according to Artifactory's configuration.
# The minimum requirement is a $key and a $repositories_ref, everything else has
# default values.
#
# See:
# Artifactory documentation on virtual repositories with all the
# configuration arguments.
#
# Usage:
#
#   artifactory::repository::virtual { 'all-remotes':
#     repositories_ref = [
#         'repo1', 'repo2', 'repo3'
#     ]
#   }
#
#
#
define artifactory::repository::virtual(
  $repositories_ref,
  $description                                        = 'Some virtual repository',
  $includes                                           = '/**',
  $layout                                             = 'maven-2-default',
  $artifactory_requests_can_retrieve_remote_artifacts = 'false',
  $pom_repository_references_cleanup_policy           = 'discard_active_reference') {

  File {
    owner  => "${artifactory::user}",
    group  => "${artifactory::user}",
    mode   => '0644',
  }

  file { "${artifactory::params::artifactory_temp_dir}/virtual-${key}.xml.content":
    ensure  => present,
    content => template('artifactory/repository/virtual.xml.erb'),
    notify  => Class['artifactory::build::virtuals'],
  }
}
