{ pkgs, ... }:

pkgs.writeShellScript "gpu-util" ''
  # Get GPU utilization using nvidia-smi and extract the percentage
  gpu_utilization=$(${pkgs.nvidia-utils}/bin/nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)

  echo "''${gpu_utilization}%"
''