set ns [new Simulator]

set nf [open o.nam w]

$ns namtrace-all $nf

set n0 [$new node]
set n1 [$new node]
set n2 [$new node]
set n3 [$new node]


$ns duplex-link $n0 $n2 20Mb 10ms DropTail

$ns duplex-link $n1 $n2 20Mb 10ms DropTail

$ns duplex-link $n2 $n3 20Mb 10ms DropTail

#creating protocols

set tcp [new Agent/TCP]
$ns attach-agent $n0 $tcp

set udp [new Agent/UDP]
$ns attach-agent $n1 $udp

set ftp [new Application/FTP]
$ftp attach-agent $tcp

set cbr [new Appliction/Traffic/CBR]
$cbr attach-agent $udp
$cbr set packet_size_ 1000

set null1 [new Agent/LossMonitor]
$ns attach-agent $n3 $null1

set null2 [new Agent/LossMonitor]
$ns attach-agent $n3 $null2

$ns connect $tcp $null1
$ns connect $udp $null2 

proc finish {} {
   global ns nf 
   $ns flush-trace
   close $nf
   exec nam o.nam &
   exit 0
}

$ns at 0.3 "$ftp start"
$ns at 19.0 "$ftp stop"
$ns at 0.5 "$cbr start"
$ns at 19.5 "$cbr stop"
$ns at 20.0 "finish"
$ns run


