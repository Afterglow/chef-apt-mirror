Description
===========

Sets up the very basics of an apt-mirror setup. Installs apt-mirror package and creates mirrors in `/etc/apt/mirror.list`

Requirements
============
Optionally: `apache2` for `recipe[mirror_apache2]`

Attributes
==========

See included example role in `examples/roles/precise-mirror.rb`

Usage
=====

Add a node with correct attributes, see `Attributes` for details.  
To configure apache2 vhost include `recipe[apt-mirror::mirror_apache2` and set `node['apt-mirror']['http']['variant']` to be 'apache2'
