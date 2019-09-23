# server "3.214.201.160", user: "shun", roles: %w{app db web}
# set :ssh_options, keys: '~/.ssh/trask_key_rsa' 

server '3.214.201.160',
   user: "shun",
   roles: %w{web db app},
   ssh_options: {
       port: 22,
       user: "shun", # overrides user setting above
       keys: %w(~/.ssh/trask_key_rsa),
       forward_agent: true
#     auth_methods: %w(publickey password)
#     # password: "please use keys"
   }
