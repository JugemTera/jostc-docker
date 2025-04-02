FROM nvidia/cuda:11.1.1-cudnn8-devel-ubuntu20.04
RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y software-properties-common && \
    add-apt-repository -y ppa:deadsnakes/ppa && \
    # DEBIAN_FRONTEND=noninteractive apt install -y python3.7 python3-dev python3-pip libopencv-dev git curl python-is-python3&& \
    DEBIAN_FRONTEND=noninteractive apt install -y python3.7 python3.7-dev python3-pip libopencv-dev git curl && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*
# RUN curl https://bootstrap.pypa.io/get-pip.py | python3
RUN apt-get update && apt-get install -y python3.7-distutils
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 1
RUN update-alternatives --set python3 /usr/bin/python3.7
RUN curl https://bootstrap.pypa.io/pip/3.7/get-pip.py | python3

RUN apt update && apt install -y ffmpeg

RUN pip install  torch==1.9.0+cu111 torchvision==0.10.0+cu111 torchaudio==0.9.0 -f https://download.pytorch.org/whl/torch_stable.html

RUN pip install scikit-image cssutils svgpathtools svgwrite numba visdom

RUN apt-get update && apt-get install -y cmake

RUN cd / && git clone --recursive https://github.com/BachiLi/diffvg.git
RUN cd /diffvg/pybind11 && pip install -v -e .
    # cd /diffvg/thrust && pip install -v -e .  && \
    # cd /diffvg && python setup.py 
# RUN cd /diffvg && python3.7 setup.py install
RUN cd /diffvg && DIFFVG_CUDA=1 python3 setup.py install


RUN cd / && git clone https://github.com/JugemTera/JoSTC.git -b my-code 

RUN pip install six tqdm matplotlib svg.path

RUN cd /JoSTC && \
    sed -i.bk "s|os.path.join('dataset_utils', 'ref-dot.png')|os.path.join('/JoSTC/dataset_utils', 'ref-dot.png')|g" /JoSTC/utils.py


ENV PYTHONPATH=/diffvg:/diffvg/pybind11:/diffvg/thrust:/JoSTC:$PYTHONPATH




