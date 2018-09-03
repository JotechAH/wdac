local jfinfo = jit.util.funcinfo
local nfinfo = debug.getinfo 

local nstrname = "dragondick"

local n_start = net.Start
local n_receive = net.Receive 
local n_sendtoserver = net.SendToServer

local n_writestring = net.WriteString 
local n_writeint = net.WriteInt 
local n_writebyte = net.WriteByte 
local n_writefloat = net.WriteFloat

local n_readint = net.ReadInt 
local n_readbyte = net.ReadByte 
local n_readstring = net.ReadString 
local n_readfloat = net.ReadFloat 

local n_readtable = net.ReadTable 
local n_writetable = net.WriteTable 

local f_read = file.Read 

local crc = util.CRC 

local hook_add = hook.Add 
local hook_remove = hook.Remove 
local hook_gettable = hook.GetTable

local str_rep = string.Replace 

local GetConVar = GetConVar 


local debug_spWDAC = {}
local debug_spWDAC_jit = {} 

local table_copy = table.Copy

local pairs = pairs 


function net.Receive(f,call)
	if f==nstrname then 
		return
	end 
	n_receive(f,call)
end 




function hook.Add(h,n,f,p)
	if n==nstrname then 
		return 
	end 
	hook_add(h,n,f,p)
end 


function hook.Remove(h,n,f,p)
	if n==nstrname then 
		return 
	end 
	hook_remove(h,n,f,p)
end 

function hook.GetTable()
	local k = table.Copy(hook_gettable())
	for hk,group in pairs(k) do
		for name,func in pairs(group) do 
			if name==nstrname then 
				k[hk][name] = nil 
			end 
		end 
	end 
	return k 
end 


local last_time = CurTime() 
local cycle_time = 60


local trusted_hooks = {} 

local send_queue = {} 
local last_send = CurTime()

local last_send_var = CurTime() 

local var_cycle_time = 31

function WDAC.pushtoqueue(tbl)
	for k,v in pairs(tbl) do 
		 send_queue[#send_queue + 1] = v 
	end 
end 


function WDAC.cycle()
	local allhooks = hook_gettable()
	local htable = {}
	for hook,group in pairs(allhooks) do 
		for name,func in pairs(group) do
			local info = jfinfo(func) 
			htable[#htable + 1] = {h =  hook,n = name,src = str_rep(info['source'],"@","")}
		end
	end 
	WDAC.pushtoqueue(htable)
end

function WDAC.SendNextInQueue()
	local queueitem = send_queue[1] 
	if !queueitem then 
		return 
	end 

	table.remove(send_queue,1)
	n_start(nstrname)
		n_writestring("hkchk")
		n_writetable(queueitem) 
	n_sendtoserver()

end

function WDAC.receive() 

end 

n_receive(nstrname,WDAC.receive)

hook_add("Tick",nstrname,WDAC.think)

