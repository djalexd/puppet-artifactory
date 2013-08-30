
define artifactory::repository::local (
    $key,
    $description    = 'Local repository',
    $includes       = '**/*',
    $layout         = 'maven-2-default',
    $nuget          = 'false',
    $releases       = 'true',
    $snapshots      = 'false',
    $max_snapshots  = '0') {

  File {
    owner  => "${artifactory::user}",
    group  => "${artifactory::user}",
    mode   => '0644',
  }

  file { "${artifactory::params::artifactory_temp_dir}/local-${key}.xml.content":
    ensure  => present,
    content => template('artifactory/repository/local.xml.erb'),
    notify  => Class['artifactory::build::locals'],
  }
}