# DOES NOT WORK
# default.apache.sites.clowns = { port : 80 }
# default.apache.sites.bears = { port : 81 }

# default['apache']['sites']['clowns'] = { "port" => 80 }
# default['apache']['sites']['bears'] = { "port" => 81 }

# default['apache']['sites']['clowns'] = { port: 80 }
# default['apache']['sites']['bears'] = { port: 81 }

default[:apache][:sites][:clowns] = { port: 80 }
default[:apache][:sites][:bears] = { port: 81 }
