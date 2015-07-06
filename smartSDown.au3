#RequireAdmin

Gexc()

Func Gexc()

   ;Configuration TCP Server
   $Ip = "0.0.0.0"
   $Port = 5555

   TCPStartup()

   Local $iListenSocket = TCPListen($Ip, $Port, 100)

   Local $iSocket = 0

   Do ; Wait for someone to connect (Unlimited).
		; Accept incomming connexions if present (Socket to close when finished; one socket per client).
		 $iSocket = TCPAccept($iListenSocket)

		If @error Then
			Gexc()
		 EndIf

	Until $iSocket <> -1 ;if different from -1 a client is connected.

   ; Close the Listening socket to allow afterward binds.
   TCPCloseSocket($iListenSocket)

   ; Assign a Local variable the data received.
   Local $sReceived = TCPRecv($iSocket, 6) ;we're waiting for the string "tata" OR "toto" (example script TCPRecv): 4 bytes length.

   If $sReceived == "reboot" Then
	  Shutdown(6) ;force reboot
   Else
	  Gexc()
   EndIf

   TCPCloseSocket($iSocket)

EndFunc


Func OnAutoItExit()
    TCPShutdown() ; Close the TCP service.
EndFunc

