eval "$(/workspace/miniconda3/bin/conda shell.bash hook)"
conda init
conda activate Comy3D_py311_cu121

python main.py --listen --port=3000