server '3.214.201.160',
   user: "shun",
   roles: %w{web db app},
   ssh_options: {
       port: 22,
       user: "shun", 
       keys: %w(~/.ssh/trask_key_rsa),
       forward_agent: true
   }
