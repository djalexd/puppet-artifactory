# Generates a backup tag in the artifactory xml configuration
# The tag has the following structure:
#<backup>
#  <key>backup-weekly</key>
#  <enabled>true</enabled>
#  <cronExp>0 0 2 ? * SAT</cronExp>
#  <retentionPeriodHours>336</retentionPeriodHours>
#  <createArchive>false</createArchive>
#  <excludedRepositories>
#     <repositoryRef>ext-release-local</repositoryRef>
#     <repositoryRef>ext-snapshot-local</repositoryRef>
#     <repositoryRef>codehaus</repositoryRef>
#     <repositoryRef>google-code</repositoryRef>
#     <repositoryRef>java.net.m2</repositoryRef>
#     <repositoryRef>jboss</repositoryRef>
#  </excludedRepositories>
#  <sendMailOnError>true</sendMailOnError>
#  <excludeBuilds>false</excludeBuilds>
#</backup>
#
# Usage
#
#   artifactory::backup { 'weekly':
#     ensure             => present,
#     cron               => '0 0 2 ? * SAT',
#     retention          => 336
#     excluded_repos     => [
#        'codehaus', 'java.net.m2', 'jboss', ...
#     ],
#     send_mail_on_error => false,
#     exclude_builds     => true
#   }
#
define artifactory::backup(
    $ensure             = 'true',
    $cron               = '0 0 * * * *',
    $retention          = '0',
    $excluded_repos     = undef,
    $send_mail_on_error = 'false',
    $exclude_builds     = 'true'
 ) {

  File {
     owner  => "${artifactory::user}",
     group  => "${artifactory::user}",
     mode   => '0644',
  }

  file { "${artifactory::params::artifactory_temp_dir}/backup-${name}.xml.content":
     ensure  => present,
     content => template('artifactory/backup.xml.erb'),
     notify  => Class['artifactory::build::backups'],
  }

}