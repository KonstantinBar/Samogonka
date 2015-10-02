local function rec(s,c) 
   if c:sub(1,4)=='IPS#' then 
   s:send('#'..wifi.ap.getip())
   print(c.." "..'#'..wifi.ap.getip())
   end
   print(c)
end

--Запуск UDP сервера
local function StartUDPServer()
 local sv
 sv=net.createServer(net.UDP, 180,wifi.ap.getip())
 sv:on("receive", function(sv,c1) rec(sv,c1)  end)
 sv:listen(6601)
end;

-- Настройка WIFI
local function setwifiImode()
if  wifi.getmode()~= 2 then wifi.setmode (wifi.SOFTAP) end
print('WIFI MODE = '..wifi.getmode())
print('IP = '..wifi.ap.getip()) 
end

setwifiImode()
--tmr.alarm(1, 500, 0, StartUDPServer())

tmr.alarm(1, 1000, 0, function() 
   StartUDPServer()
end)
