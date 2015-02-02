#   (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
#   All rights reserved. This program and the accompanying materials
#   are made available under the terms of the Apache License v2.0 which accompany this distribution.
#
#   The Apache License is available at
#   http://www.apache.org/licenses/LICENSE-2.0
#
####################################################
#   This operation will check the disk space percentage on a Linux machine.
#
#   Inputs:
#       - host - Docker machine host
#       - port - optional - SSH port - Default: 22
#       - username  - Docker machine username
#       - password - Docker machine password
#   Outputs:
#       - diskSpace - percentage - ex. (50%)
#   Results:
#       - SUCCESS - operation finished successfully
#       - FAILURE - otherwise
####################################################

namespace: org.openscore.slang.docker.linux

operations:

    - check_linux_disk_space:
          inputs:
            - host
            - port:
                default: "'22'"
                required: false
            - username
            - password
            - privateKeyFile:
                default: "''"
                overridable: false
            - command:
                default: |
                    'df -kh | grep -v "Filesystem" | awk \'NR==1{print $5}\''
                overridable: false
            - arguments:
                default: "''"
                overridable: false
            - characterSet:
                default: "'UTF-8'"
                overridable: false
            - pty:
                default: "'false'"
                overridable: false
            - timeout:
                default: "'30000000'"
                overridable: false
            - closeSession:
                default: "'false'"
                overridable: false
          action:
            java_action:
              className: org.openscore.content.ssh.actions.SSHShellCommandAction
              methodName: runSshShellCommand
          outputs:
            - diskSpace: STDOUT.replace("\n", "")
          results:
            - SUCCESS
            - FAILURE