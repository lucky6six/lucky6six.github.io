# pytorch源码
202.120.32.245 ： 9081
localhost, 127.0.0.0/8, ::1
编译
![[168728508-df501c1e-2f8b-444b-a81e-fa1f0563bede-1.jpg]
python 3.6
cuda 11.7
pytorch（1.8.0/direct）

```
#prepare conda
conda create -n py36 python=3.6 
conda activate py36
conda install -y numpy ninja pyyaml mkl mkl-include setuptools cmake cffi typing_extensions future six requests dataclasses
#linux
conda install -y -c pytorch magma-cuda117
```

```
#prepare code
git clone --recursive https://github.com/K-Wu/pytorch-direct.git
cd pytorch-direct
git submodule sync
git submodule update --init --recursive
```
```
#install pytorch
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
export CMAKE_PREFIX_PATH=${CONDA_PREFIX:-"$(dirname $(which conda))/../"}
conda install -y torchvision
python setup.py install
```
### 踩坑指南：
- 编译过程中数学库math相关问题:常见于较旧版本的pytorch
>在./caffe2/utils/math_gpu.cu中#include <thrust/host_vector.h>
- torch中部分库缺失：可能是编译过程中有中断后继续编译，导致部分内容编译链接有误。
>重新编译
python setup.py clean
python setup.py install
pyt

可能的问题：torchvision需要在编译前安装