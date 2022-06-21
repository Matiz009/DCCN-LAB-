#Creating Simulator
set ns [new Simulator]
set nf [open o.nam w]
$ns namtrace-all $nf

#Creating nodes

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

#Creating links between nodes

$ns duplex-link $n0 $n2 20Mb 10ms DropTail

$ns duplex-link $n1 $n2 20Mb 10ms DropTail

$ns duplex-link $n2 $n3 20Mb 10ms DropTail




#Creation of Protocols
set tcp [new Agent/TCP]
$ns attach-agent $n0 $tcp

set udp [new Agent/UDP]
$ns attach-agent $n1 $udp


set ftp [new Application/FTP]
$ftp attach-agent $tcp

set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp
$cbr set packet_size_ 10000

set null1 [new Agent/LossMonitor] 
$ns attach-agent $n3 $null1

set null2 [new Agent/LossMonitor]
$ns attach-agent $n3 $null2

$ns connect $tcp $null1
$ns connect $udp $null2


#Finish Procedure

proc finish { } {

  global ns nf
  $ns flush-trace
  close $nf
  exec nam o.nam &
  exit 0

}

$ns at 0.1 "$ftp start"
$ns at 19.0 "$ftp stop"
$ns at 0.3 "$cbr start"
$ns at 19.5 "$cbr stop"

$ns at 20.0 "finish"
$ns run



