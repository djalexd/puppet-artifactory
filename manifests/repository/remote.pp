#
# Defines a remote repository, according to Artifactory's configuration.
# The minimum requirement is a $key and a $url, everything else has
# default values.
#
# See:
# Artifactory documentation on remote repositories with all the
# configuration arguments.
#
# Usage:
#
#   artifactory::repository::remote { 'central':
#     url => 'http://repo1.maven.org/maven2'
#   }
#
#
#
define artifactory::repository::remote(
  $url,
  $description                           = 'Some remote repository',
  $includes                              = '/**',
  $excludes                              = '',
  $layout                                = 'maven-2-default',
  $handle_releases                       = 'true',
  $handle_snapshots                      = 'true',
  $max_unique_snapshots                  = '0',
  $suppress_pom_consistency_checks       = 'false',
  $archive_browsing_enabled              = 'false',
  $offline                               = 'false',
  $hard_fail                             = 'false',
  $store_artifact_locally                = 'true',
  $fetch_jars_eagerly                    = 'false',
  $fetch_sources_eagerly                 = 'false',
  $retrieval_cache_period_secs           = '43200',
  $assumed_offline_period_secs           = '300',
  $missed_retrieval_cache_period_secs    = '7200',
  $remote_repo_checksum_policy_type      = 'generate-if-absent',
  $unused_artifacts_cleanup_period_hours = '0',
  $share_configuration                   = 'false',
  $synchronize_properties                = 'false',
  $list_remote_folder_items              = 'false',
  $reject_invalid_jars                   = 'true',
  $p2_support                            = 'false',
  $socket_timeout_millis                 = '15000') {

  File {
    owner  => "${artifactory::user}",
    group  => "${artifactory::user}",
    mode   => '0644',
  }

  file { "${artifactory::params::artifactory_temp_dir}/remote-${key}.xml.content":
    ensure  => present,
    content => template('artifactory/repository/remote.xml.erb'),
    notify  => Class['artifactory::build::remotes'],
  }
}
