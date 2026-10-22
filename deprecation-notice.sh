#!/bin/sh
# Prints a deprecation notice to the container log at start and then periodically,
# afterwards hands over to the original Nextcloud entrypoint unchanged.
notice() {
  cat >&2 <<'MSG'

################################################################################
##                                                                            ##
##   !!!  DEPRECATED IMAGE – NO MORE UPDATES  !!!                             ##
##                                                                            ##
##   ghcr.io/maximilian1001/nextcloud-smb is no longer maintained and stays   ##
##   on Nextcloud 30 (end of life, known security issues).                    ##
##                                                                            ##
##   Switch to:  ghcr.io/maximilian1001/docker-all-nextcloud-smb:30-apache    ##
##   then upgrade one major version at a time (31-apache, 32-apache, ...).    ##
##                                                                            ##
##   https://github.com/maximilian1001/docker-all-nextcloud-smb               ##
##                                                                            ##
################################################################################

MSG
}

notice
interval="${DEPRECATION_NOTICE_INTERVAL:-3600}"
if [ "$interval" -gt 0 ] 2>/dev/null; then
  ( while sleep "$interval"; do notice; done ) &
fi

exec /entrypoint.sh "$@"
