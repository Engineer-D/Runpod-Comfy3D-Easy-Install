#install sudo
apt-get update
apt install sudo

# Install build tools:
sudo apt update
sudo apt install gcc g++

# Install Miniconda: 
# https://www.rosehosting.com/blog/how-to-install-miniconda-on-ubuntu-22-04/
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda-installer.sh
bash miniconda-installer.sh

# when prompted part to save type /workspace/miniconda3
# this allows for the whole installtion not to clear when you pause the instance or restart it

# configure shell to run miniconda
eval "$(/workspace/miniconda3/bin/conda shell.bash hook)"

# initialize conda
conda init

# Open Miniconda prompt
source ~/.bashrc

# Create and activate conda environments
conda create --name Comy3D_py311_cu121 python=3.11
conda activate Comy3D_py311_cu121


# install Comfyui
git clone https://github.com/comfyanonymous/ComfyUI.git
cd ComfyUI
pip install -r requirements.txt

#install ComfyUI Manager
cd custom_nodes
git clone https://github.com/ltdrdata/ComfyUI-Manager.git
cd ComfyUI-Manager
pip install -r requirements.txt


#install Comfy3D pack from my repository
cd ..
git clone https://github.com/Engineer-D/ComfyUI-3D-Pack.git

# Build Wheels with cuda 12.1:
export CUDA_HOME="/usr/local/cuda-12.1/"
../../miniconda3/envs/Comy3D_py311_cu121/bin/python ./ComfyUI-3D-Pack/_Pre_Builds/_Build_Scripts/auto_build_all.py
cd ComfyUI-3D-Pack
pip install -r requirements.txt


#install pointnet2_ops_lib
cd ../../..
git clone https://github.com/VAST-AI-Research/TriplaneGaussian.git
cd TriplaneGaussian
cd tgs/models/snowflake/pointnet2_ops_lib && python setup.py install && cd -

# Build wheels for pytorch3d, torch-scatter, kiui
cd ~
cd ../workspace
pip install "git+https://github.com/facebookresearch/pytorch3d.git"
pip install torch-scatter -f https://data.pyg.org/whl/torch-2.4.0+${CUDA}.html
pip install git+https://github.com/ashawkey/kiuikit.git

# Install nvdiffrast
git clone --recursive https://github.com/NVlabs/nvdiffrast
cd  nvdiffrast
pip install .

# install diff-gaussian-rasterization
cd ..
git clone --recursive https://github.com/ashawkey/diff-gaussian-rasterization
pip install ./diff-gaussian-rasterization


# Start up ComfyUI
cd ComfyUI
python main.py --listen --port=3000