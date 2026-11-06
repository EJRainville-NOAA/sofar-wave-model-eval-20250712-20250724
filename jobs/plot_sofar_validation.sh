#!/bin/sh
#SBATCH --nodes=1
#SBATCH -q debug
#SBATCH -t 00:30:00
#SBATCH -A marine-cpu
#SBATCH -J plot_experiment_matchup
#SBATCH -o ./logs/plot_experiment_matchup.out
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16G
#SBATCH --open-mode=truncate

# ====== USER INPUT ================
CONFIG_FILE="/scratch3/NCEPDEV/marine/Edwin.Rainville/sofar-wave-model-eval-20250712-20250724/jobs/experiment_config.yaml"
WW3TOOLS_DIR="/scratch3/NCEPDEV/marine/Edwin.Rainville/ww3-tools-dev"
# ==================================

echo "Loading modules"
module purge
module use /scratch4/NCEPDEV/marine/Saeideh.Banihashemi/installs/python-modules/
module load ursa-env
module load bufr

export PATH="/scratch4/NCEPDEV/marine/Saeideh.Banihashemi/installs/ursa-env/bin:$PATH"
export PYTHONPATH="/scratch3/NCEPDEV/marine/Edwin.Rainville/ww3-tools-dev${PYTHONPATH:+:${PYTHONPATH}}"
PLOT_SCRIPT="${WW3TOOLS_DIR}/ww3tools/scripts/sofar_validation_plots.py"

echo "Starting to make plots"

# Execute using the YAML config file
python -u "$PLOT_SCRIPT" --config "$CONFIG_FILE"

echo "Job completed."
