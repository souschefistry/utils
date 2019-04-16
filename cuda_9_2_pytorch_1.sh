# enable ubuntu repository
sudo add-apt-repository main
sudo add-apt-repository universe
sudo add-apt-repository restricted
sudo add-apt-repository multiverse

# update 
sudo apt-get update

# install yum and htop
sudo apt-get install yum
sudo apt-get install htop

# install nvidia drive
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt update
sudo apt-get install nvidia-410 nvidia-modprobe # cuda 9.2
reboot

#install anaconda - python 3.6 / 3.7 
wget --header="Host: repo.anaconda.com" --header="User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36" --header="Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8" --header="Accept-Language: en-US,en;q=0.9" --header="Cookie: __cfduid=d05716684bf2bf8760d3fa2f66a267f0f1540723770; _ga=GA1.2.646766809.1540723771; _gid=GA1.2.1389839630.1542433218" --header="Connection: keep-alive" "https://repo.anaconda.com/archive/Anaconda3-5.3.0-Linux-x86_64.sh" -O "Anaconda3-5.3.0-Linux-x86_64.sh" -c

# pytorch-nightly + fastai
conda install -c pytorch pytorch-nightly cuda92 cudatoolkit=9.0
conda install -c fastai torchvision-nightly
conda install -c fastai fastai
conda install bcolz opencv-python seaborn graphviz scikit-learn sklearn-pandas isoweek pandas_summary torchtext
