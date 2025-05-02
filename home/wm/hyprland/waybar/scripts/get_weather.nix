{ pkgs, ... }:

pkgs.writeShellScript "get_weather.sh" ''
  #!/usr/bin/env bash
  for i in {1..5}; do
    text=$(${pkgs.curl}/bin/curl -s "https://wttr.in/$1?format=1")
    if [[ $? == 0 ]]; then
      text=$(echo "$text" | ${pkgs.gnused}/bin/sed -E "s/\s+/ /g")
      tooltip=$(${pkgs.curl}/bin/curl -s "https://wttr.in/$1?format=4")
      if [[ $? == 0 ]]; then
        tooltip=$(echo "$tooltip" | ${pkgs.gnused}/bin/sed -E "s/\s+/ /g")
        echo "{\"text\":\" $text\", \"tooltip\":\" $tooltip\"}"
        exit
      fi
    fi
    sleep 2
  done
  # echo "{\"text\":\"error\", \"tooltip\":\"error\"}"
  echo "{\"text\":\"\", \"tooltip\":\"\", \"alt\": \"error\"}"
''