# Ansible Examples

This Git repository contains a couple of branches that showcase some of the key principles in designing and developing playbooks and roles.

More information on the settings and ideas demonstrated is available in each branch.

The branches are:

`standard-playbook`
: A standard UNIX service (configurable via text files) deployment playbook.
: This playbook really deploys three services on four nodes: an `unbound` caching nameserver, a primary `bind` service, and two secondary `bind` DNS servers, and configures them.

`standard-role`
: The above playbook, converted into a generic role that can be used to deploy any standard UNIX service.
: This also integrates with `molecule` and has some test playbooks (and an inventory) in the role's `tests/` directory (including a change rollback playbook).

`nonstandard-playbook`
: A simple playbook for a non-standard service, requiring the use of service-specific modules.

`parallelism`
: A couple of playbooks showcasing serialisation, asynchronous execution, and other parallelisation techniques.

`misc`
: These are some of the demos that have not been classified yet, or are too small to have a branch of their own.

Enjoy!

## How to set up the environment?

For developing and testing using any recent combination of tools, a python
virtual environment is probably the easiest choice.

1. Create and activate a virtual environment:

```bash
$ python3 -mvenv ./molecule
$ bash
$ source ../molecule/bin/activate
(molecule) $
```

2. Install `ansible-core`, `molecule` and its plugins, and the linting tools:

```bash
(molecule) $ pip3 install --upgrade pip molecule-plugins[podman,containers] yamllint ansible-lint
...
Successfully installed ... ansible-core-2.18.2 ... molecule-25.2.0 molecule-plugins-23.7.0 ...
```

3. _optional_ If working on Mac or Windows, ensure your Podman VM is started

```bash
(molecule) $ podman machine start
Starting machine "podman-machine-default"
...
Machine "podman-machine-default" started successfully
```

> *NOTE:* You may have to set up a Podman machine first using the `podman
> machine init` command (or use Podman Desktop to do the same).

## Where are the playbook and role examples?

You simply need to clone this repository after you installed all the tools:

```bash
(molecule) $ git clone https://github.com/rhtuser/ansible-examples.git
Cloning into 'ansible-examples'...
...
Receiving objects: 100% (117/117), 30.50 KiB | 2.54 MiB/s, done.
Resolving deltas: 100% (27/27), done.
```

Alternatively, if you want to work on your own copy and push changes to the
repository, log into GitHub with your own account, open the `ansible-examples`
repository in a browser, and fork it. You can then fork the repository from
your own account.

Enter the working copy and switch to a branch you want to work on.

```bash
(molecule) $ cd ansible-examples
(molecule) $ git branch -l --remote
  origin/HEAD -> origin/main
  origin/main
  origin/misc
  origin/nonstandard-playbook
  origin/parallelism
  origin/standard-playbook
  origin/standard-role
(molecule) $ git checkout misc
branch 'misc' set up to track 'origin/misc'.
Switched to a new branch 'misc'
```

## How do I run the examples?

There are two types of examples, those which do not involve Molecule, but
rather just run Ansible plays against some hosts, and those that use Molecule
for testing, in which case the lifecycle of containers is managed by Molecule.

### Examples with Plain Ansible

For plain Ansible examples, you will need some adjustments to the inventory
files, as they refer to bogus server names wich most probably do not resolve to
IPs in your environment.

While you could run those plays against a set of virtual machines, setting
those up for networking is simple, you just need to change the inventory files
to reflect their hostnames (or add `ansible_host=` if they do not resolve from
your control node).

Create a new Podman network and note its IP range.

```bash
(molecule) $ podman network create ansible
ansible
(molecule) $ podman network inspect ansible
[
     {
          "name": "ansible",
          ...
          "subnets": [
               {
                    "subnet": "10.89.0.0/24",
                    "gateway": "10.89.0.1"
               }
          ],
          ...
          "dns_enabled": true,
          ...
     }
]
```

Create some containers running off of an image that has a recent enough version
of Python.

```bash
(molecule) $ podman run -d --rm --name servera --network ansible registry.access.redhat.com/ubi9/python-312:latest sleep 10000
5f7a17bb1da39570d7d1753713634fb26909f42acd8367f56a9fa80ab5363003
```

Look up the container IP:

```bash
(molecule) $ podman inspect -f '{{.NetworkSettings.Networks.ansible.IPAddress}}' servera
10.89.0.3
```

Finally, add the IP to the inventory file as that host's IP address.

```ini
[servers]
servera ansible_host=10.89.0.3
```

> TODO: figure out how this works on macOS with machines.

### Examples with Molecule

It is much easier to run Molecule tests as it manages container lifecycle for you.

TBD.

## How to remove the environment?

Simply exit any shell that is using the virtual environment and remove the directory.

```bash
(molecule) $ exit
$ rm -rf ./molecule
```

Done!

