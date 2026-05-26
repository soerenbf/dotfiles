function wol --description "Wake an SSH host via Wake-on-LAN"
  if test (count $argv) -ne 1
    echo "Usage: wol <ssh-host>" >&2
    return 1
  end

  set -l host $argv[1]
  set -l ip (ssh -G $host 2>/dev/null | awk '/^hostname / { print $2; exit }')

  if test -z "$ip"
    echo "Could not resolve HostName for $host from ~/.ssh/config" >&2
    return 1
  end

  set -l mac
  switch $host
    case sbz_linux
      set mac 04:42:1a:ea:6b:d2
    case '*'
      set mac (arp -n $ip 2>/dev/null | awk '/ at / { print $4; exit }')
  end

  if test -z "$mac"
    echo "Could not determine MAC address for $host ($ip)" >&2
    echo "Add it to ~/.config/fish/functions/wol.fish or ensure it is present in the ARP cache." >&2
    return 1
  end

  set -l octets (string split . -- $ip)
  if test (count $octets) -ne 4
    echo "HostName for $host is not an IPv4 address: $ip" >&2
    return 1
  end

  set -l broadcast "$octets[1].$octets[2].$octets[3].255"

  if not command -sq wakeonlan
    echo "wakeonlan is not installed" >&2
    return 1
  end

  echo "Waking $host via MAC $mac using broadcast $broadcast"
  command wakeonlan -i $broadcast $mac
  or begin
    echo "Failed to send Wake-on-LAN packet via wakeonlan" >&2
    return 1
  end
end
