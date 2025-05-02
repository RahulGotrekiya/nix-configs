{ pkgs, ... }:

pkgs.writeShellScript "gpu-temp" ''
  gpu_id=0  # Change this to the desired GPU ID (e.g., 0, 1, 2, etc.)

  # Get GPU temperature using nvidia-smi and extract the value in degrees Celsius
  gpu_temperature=$(${pkgs.nvidia-utils}/bin/nvidia-smi --id=''${gpu_id} --query-gpu=temperature.gpu --format=csv,noheader,nounits)

  echo "''${gpu_temperature}°C"
''