

sroute 'name' do
   action :add
   persistence true
   target_net '10.63.0.0'
   netmask '255.255.0.0'
   gw  '161.169.237.129'
end
