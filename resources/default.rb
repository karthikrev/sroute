actions :add, :delete, :flush, :change
default_action :add

#attribute: default_gw: kind_of => [TrueClass, FalseClass]
#attribute :target_host :kind_of => String
#attribute :target_net :kind_of  => String
#attribute :gateway :kind_of => String
#attribute :netmask :kind_of => String
#attribute: reject: kind_of => [TrueClass, FalseClass] 


attribute :default_gw,
          :kind_of => String

attribute :target_host,
          :kind_of => String

attribute :target_net,
          :kind_of => String

attribute :gw,
          :kind_of => String

attribute :netmask,
          :kind_of => String

attribute :device,
          :kind_of => String

attribute :reject,
          :kind_of => [TrueClass, FalseClass],
          :default => false

attribute :persistence,
          :kind_of => [TrueClass, FalseClass],
          :default => true  

attribute :flush,
          :kind_of => [TrueClass, FalseClass],
          :default => false 

attribute :ifp,
          :kind_of => String
