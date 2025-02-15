# Ansible Examples

This Git repository contains a couple of branches that showcase some of the key principles in designing and developing playbooks and roles.

More information on the settings and ideas demonstrated is available in each branch.

The branches are:

* `standard-playbook` - a standard UNIX service (configurable via text files) deployment playbook
* `standard-role` - the same, but converted into a generic role
* `nonstandard-playbook` - a non-standard service (requiring the use of specific modules) deployment playbook
* `misc` - some of the demos that have not been classified yet, or are too small to have a branch of their own

Enjoy!

## How to set up the environment?

For developing and testing using any recent combination of tools, a python
virtual environment is probably the easiest choice.

1. Create and activate a virtual environment:

```
$ python3 -mvenv ./molecule
$ bash
$ source ../molecule/bin/activate
(molecule) $
```

2. Install `ansible-core`, `molecule` and its plugins, and the linting tools:

```
(molecule) $ pip3 install --upgrade pip molecule-plugins[podman,containers] yamllint ansible-lint
...
Successfully installed ... ansible-core-2.18.2 ... molecule-25.2.0 molecule-plugins-23.7.0 ...
```

3. _optional_ If working on Mac or Windows, ensure your Podman VM is started

```
(molecule) $ podman machine start
Starting machine "podman-machine-default"
...
Machine "podman-machine-default" started successfully
```

## Where are the playbook and role examples?

You simply need to clone this repository after you installed molecule:

```
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

```
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

## How to remove the environment?

Simply exit any shell that is using the virtual environment and remove the directory.

```
(molecule) $ exit
$ rm -rf ./molecule
```

Done!

