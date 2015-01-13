#def load_current_resource
    #new_resource.key new_resource.name unless new_resource.key
    #puts new_resource.default_gw
    #puts "loading"
#end

use_inline_resources

action :add do
    do_route('add') 
end

action :delete do
    do_route('delete')
end


def do_route(action)

    # LINUX
    #target = ""
    #target = ("-host #{new_resource.target_host}" if new_resource.target_host)
    #target = ("-net #{new_resource.target_net}" if new_resource.target_net)  if not target

    #exit_path = "gw #{new_resource.gw}" if new_resource.gw
    #exit_path = ("default gw #{new_resource.default_gw}" if new_resource.default_gw) if not exit_path
    #exit_path = ("dev #{new_resource.device}" if new_resource.device) if not exit_path 
    
    #reject = "reject" if new_resource.reject
    #netmask = "netmask #{new_resource.netmask}" if new_resource.netmask 

    #cmdStr = "/sbin/route #{action} #{target} #{netmask} #{exit_path} #{reject}"    
    #puts "\n"
    #puts cmdStr


    #SOLARIS
    target = ""
    target = ( ("-host #{new_resource.target_host}" if new_resource.target_host)  or ("-net #{new_resource.target_net}" if new_resource.target_net) ) 
    exit_path = (new_resource.gw or ("default #{new_resource.default_gw}" if new_resource.default_gw))
    netmask = "-netmask #{new_resource.netmask}" if new_resource.netmask
    ifp =  ( "-ifp #{new_resource.ifp}" if new_resource.ifp )
    reject = "reject" if new_resource.reject
    persistence = "-p" if new_resource.persistence
    flush = "-f" if new_resource.flush
    puts "\n"
    cmdStr = "/sbin/route #{persistence} #{flush} #{action} #{target} #{netmask} #{exit_path} #{ifp} #{reject}"
    Chef::Log.info "Executing command #{cmdStr}" 
    cmd = Mixlib::ShellOut.new(cmdStr)
    cmd.run_command
    Chef::Log.debug cmd.stdout
    begin
        cmd.error!
    rescue
        if cmd.stderr["entry exists"] or cmd.stderr["not in file"]  or cmd.stdout["entry exists"] or cmd.stdout["not in file"]
            return
        end
        raise "Error #{cmd.stdout} #{cmd.stderr} in command #{cmdStr}"
    end
    Chef::Log.info "Updating routing table with #{cmdStr}"
    new_resource.updated_by_last_action(true)

end
