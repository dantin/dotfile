#!/bin/bash

spinner() {
    local lines='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $1)" ]; do
        local temp=${lines#?}
        printf "\r [%c]  " "$lines"
        local lines=$temp${lines%"$temp"}
        sleep 0.15
    done
    printf "\r"
}

calc_disk() {
    local total_size=0
    local array=$@
    for size in ${array[@]}
    do
        [ "${size}" == "0" ] && size_t=0 || size_t=`echo ${size:0:${#size}-1}`
        [ "`echo ${size:(-1)}`" == "K" ] && size=0
        [ "`echo ${size:(-1)}`" == "M" ] && size=$( awk 'BEGIN{printf "%.1f", '$size_t' / 1024}' )
        [ "`echo ${size:(-1)}`" == "T" ] && size=$( awk 'BEGIN{printf "%.1f", '$size_t' * 1024}' )
        [ "`echo ${size:(-1)}`" == "G" ] && size=${size_t}
        total_size=$( awk 'BEGIN{printf "%.1f", '$total_size' + '$size'}' )
    done
    echo ${total_size}
}

sysinfo() {

    rm -rf $HOME/bench.log
    # CPU model
    cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo | sed 's/^[ \t]*//;s/[ \t]*$//' )
    # CPU cores
    cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
    # CPU frequency in MHz
    freq=$( awk -F: '/cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo | sed 's/^[ \t]*//;s/[ \t]*$//' )
    # total memeory in MB
    tram=$( free -m | awk 'NR==2 {print $2}' )
    # Swap in MB
    vram=$( free -m | awk 'NR==3 {print $2}' )
    # System uptime
    up=$( uptime | awk '{ $1=$2=$(NF-6)=$(NF-5)=$(NF-4)=$(NF-3)=$(NF-2)=$(NF-1)=$NF=""; print}' | sed 's/^[ \t]*//;s/[, \t]*$//' )
    # Operation System and version
    opsys=$( cat /etc/os-release | grep PRETTY_NAME | tr -d '"' | sed -e "s/^PRETTY_NAME=//" )
    # Architecture in Bit
    arch=$( uname -m )
    lbit=$( getconf LONG_BIT )
    # Kernel
    kernel=$( uname -r )
    # Hostname
    hn=$( hostname )
    # Disk size
    disk_total=$( LANG=C df -hPl | grep -wvE '\-|none|tmpfs|devtmpfs|by-uuid|chroot|Filesystem' | awk '{print $2}' )
    disk_used=$( LANG=C df -hPl | grep -wvE '\-|none|tmpfs|devtmpfs|by-uuid|chroot|Filesystem' | awk '{print $3}' )
    disk_total_size=$( calc_disk ${disk_total[@]} )
    disk_used_size=$( calc_disk ${disk_used[@]} )
    # IPv4, IPv6
    ipv4=$( wget -qO- ipv4.icanhazip.com )
    ipv6=$( wget -qO- ipv6.icanhazip.com )

    # Date of benchmark
    bdates=$( date )
    echo "Benchmark started on $bdates" | tee -a $HOME/bench.log
    echo "Full benchmark log: $HOME/bench.log" | tee -a $HOME/bench.log
    echo "" | tee -a $HOME/bench.log
    # Output of results
    echo "System Info" | tee -a $HOME/bench.log
    echo "-----------" | tee -a $HOME/bench.log
    echo "Hostname    : $hn" | tee -a $HOME/bench.log
    echo "Uptime      : $up" | tee -a $HOME/bench.log
    echo "" | tee -a $HOME/bench.log
    echo "Processor   : $cname" | tee -a $HOME/bench.log
    echo "CPU Cores   : $cores" | tee -a $HOME/bench.log
    echo "Frequency   : $freq MHz" | tee -a $HOME/bench.log
    echo "Memory      : $tram MB" | tee -a $HOME/bench.log
    echo "Swap        : $vram MB" | tee -a $HOME/bench.log
    echo "Disk        : $disk_total_size GB ($disk_used_size GB used)" | tee -a $HOME/bench.log
    echo "" | tee -a $HOME/bench.log
    echo "OS          : $opsys" | tee -a $HOME/bench.log
    echo "Arch        : $arch ($lbit Bit)" | tee -a $HOME/bench.log
    echo "Kernel      : $kernel" | tee -a $HOME/bench.log
    echo "" | tee -a $HOME/bench.log
    echo "Public IPv4 : $ipv4" | tee -a $HOME/bench.log
    echo "Public IPv6 : $ipv6" | tee -a $HOME/bench.log
    echo "" | tee -a $HOME/bench.log

}

pingtest() {

    echo "Ping Test" | tee -a $HOME/bench.log
    echo "---------" | tee -a $HOME/bench.log
    echo "DigitalOcean Ping Test:" | tee -a $HOME/bench.log
    echo "" | tee -a $HOME/bench.log
    for DC in NYC1 NYC2 NYC3 SFO1 SFO2 TOR1 LON1 FRA1 AMS2 AMS3 SGP1 BLR1
    do
        printf "$DC: \t$(ping -i .2 -c 10 -q speedtest-$DC.digitalocean.com | awk -F/ '/^round|^rtt/{print $5}') ms\n" | expand -t 20 | tee -a $HOME/bench.log
    done
    echo "" | tee -a $HOME/bench.log

    echo "Linode Ping Test:" | tee -a $HOME/bench.log
    echo "" | tee -a $HOME/bench.log
    for DC in Newark Atlanta Dallas Fremont London Frankfurt Singapore Tokyo2
    do
        printf "$DC: \t$(ping -i .2 -c 10 -q speedtest.$DC.linode.com | awk -F/ '/^round|^rtt/{print $5}') ms\n" | expand -t 20 | tee -a $HOME/bench.log
    done
    echo "" | tee -a $HOME/bench.log

    echo "AWS Ping Test:" | tee -a $HOME/bench.log
    echo "" | tee -a $HOME/bench.log
    for DC in us-east-1 us-east-2 us-west-1 us-west-2 eu-north-1 ca-central-1 eu-central-1 eu-west-1 eu-west-2 eu-west-3 eu-north-1 ap-east-1 ap-northeast-1 ap-northeast-2 ap-northeast-3 ap-south-1 ap-southeast-1 ap-southeast-2 sa-east-1 me-south-1
    do
        printf "$DC: \t$(ping -i .2 -c 10 -q ec2.$DC.amazonaws.com | awk -F/ '/^round|^rtt/{print $5}') ms\n" | expand -t 20 | tee -a $HOME/bench.log
    done
    echo "" | tee -a $HOME/bench.log

}

speedtest() {

    echo "Speed Test"
    echo "----------"
    #echo "DigitalOcean Speed Test: (100MB each)"
    #echo ""
    #for DC in SGP1
    #do
    #    printf "$DC: \e\n"
    #    printf "$(wget -O /dev/null http://speedtest-$DC.digitalocean.com/100mb.test 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}')\e\n" & spinner $!
    #done

    #printf "\n\nLinode Speed Test: (100MB each)\n\n"

    #for DC in tokyo2
    #do
    #    printf "$DC: \e\n"
    #    printf "$(wget -O /dev/null http://speedtest.$DC.linode.com/100MB-$DC.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}')\e\n" & spinner $!
    #done

    printf "\n\nAWS Speed Test: (10MB each)\n\n"

    for DC in ap-northeast-1 ap-northeast-2
    do
        printf "$DC: \e\n"
        printf "$(wget -O /dev/null http://$DC-ec2.cloudharmony.net/probe/test10mb.jpg 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}')\e\n" & spinner $!
    done

}

iotest() {

    echo "Disk Speed" | tee -a $HOME/bench.log
    echo "----------" | tee -a $HOME/bench.log
    # Measuring disk speed with `dd`
    io=$( ( dd if=/dev/zero of=test_$$ bs=64k count=16k conv=fdatasync && rm -f test_$$ ) 2>&1 | awk -F, '{io=$NF} END {print io}' | sed 's/^[ \t]*//;s/[ \t]*//' )
    io2=$( ( dd if=/dev/zero of=test_$$ bs=64k count=16k conv=fdatasync && rm -f test_$$ ) 2>&1 | awk -F, '{io=$NF} END {print io}' | sed 's/^[ \t]*//;s/[ \t]*//' )
    io3=$( ( dd if=/dev/zero of=test_$$ bs=64k count=16k conv=fdatasync && rm -f test_$$ ) 2>&1 | awk -F, '{io=$NF} END {print io}' | sed 's/^[ \t]*//;s/[ \t]*//' )
    # Calculate avg I/O
    ioraw=$( echo $io | awk 'NR==1 {print $1}' )
    ioraw2=$( echo $io2 | awk 'NR==1 {print $1}' )
    ioraw3=$( echo $io3 | awk 'NR==1 {print $1}' )
    ioall=$( awk 'BEGIN{print '$ioraw' + '$ioraw2' + '$ioraw3'}' )
    ioavg=$( awk 'BEGIN{print '$ioall'/3}' )
    # Output of results
    echo "I/O (1st run)     : $io" | tee -a $HOME/bench.log
    echo "I/O (2nd run)     : $io2" | tee -a $HOME/bench.log
    echo "I/O (3rd run)     : $io3" | tee -a $HOME/bench.log
    echo "Average I/O       : $ioavg MB/s" | tee -a $HOME/bench.log
    echo "" | tee -a $HOME/bench.log

}

hlp() {

    echo ""
    echo "(C) bench.sh"
    echo ""
    echo "Usage: bench.sh <option>"
    echo ""
    echo "Available options:"
    echo ""
    echo "-sys           : Displays system information, e.g. CPU, RAM, Disk, IPv4, IPv6, etc."
    echo "-io            : Runs disk speed test."
    echo "-ping          : Runs network latency test."
    echo "-speed         : Runs network speed test."
    echo "-h             : Shows help."
    echo "No option      : Displays system information will be run."
    echo ""

}

case $1 in
    '-sys')
        sysinfo
    ;;
    '-io')
        iotest
    ;;
    '-ping')
        pingtest 
    ;;
    '-speed')
        speedtest
    ;;
    '-h')
        hlp
    ;;
    *)
        sysinfo
        iotest
        pingtest
	;;
esac
