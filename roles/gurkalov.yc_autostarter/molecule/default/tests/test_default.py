import os

import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


def test_healthcheck_file(host):
    f = host.file('/var/job/yc-autostarter/healthcheck.php')

    assert f.exists


def test_env_file(host):
    f = host.file('/var/job/yc-autostarter/.env')

    assert f.exists
