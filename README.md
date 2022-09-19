# uvm

Questa FPGA Edhitionのライセンス認証方法

[https://www.macnica.co.jp/business/semiconductor/articles/intel/139706/]

ライセンス設定なしで使用できる最後のModelSim-ISEはQuartus Standardのダウンロードページ内"Individual Files"タブからダウンロードできる

[https://www.intel.com/content/www/us/en/software-kit/661015/intel-quartus-prime-standard-edition-design-software-version-20-1-for-windows.html]

Intel® FPGA Self-Service Licensing Center

[https://licensing.intel.com/psg/s/?language=ja]


```
sudo dnf -y install libXext.i686
sudo dnf -y install libgcc.i686
sudo yum install glibc-devel.i686
sudo dnf -y groupinstall "Development Tools"
```

```
cd ~
UVM_SRC=/opt/intelFPGA/20.1/modelsim_ase/verilog_src/uvm-1.2/src
vlog -sv $UVM_SRC/uvm.sv +incdir+$UVM_SRC $UVM_SRC/dpi/uvm_dpi.cc -ccflags -DQUESTA
vmap -modelsimini modelsim.ini  uvm work
```

# 手順1
UVMライブラリをコンパイルする

## 1. Questaインストールディレクトリ内UVMライブラリのMakefileを修正
* `MTI_HOME`を追加
* `UVM_HOME`と`GCC`をQuestaインストールディレクトリへ合わせる


```Makefile
MTI_HOME = /opt/intelFPGA/20.1/modelsim_ase
#UVM_HOME ?= ..
UVM_HOME = $(MTI_HOME)/verilog_src/uvm-1.2
#GCC     = gcc
GCC     = $(MTI_HOME)/gcc-7.4.0-linux_x86_64/bin/g++
```

## 2. make実行
```
sudo make -f Makefile.questa dpi_lib
```

# 手順2
vlig/vsim実行スクリプトを作成する

## 1. Questa内UVM-1.2では、テストベンチの`vlog`コマンド内でUVMライブラリをコンパイルする
別途、`gcc`コマンドでUVMライブラリをコンパイルする必要がなく、vlog時にQuestaが内蔵gccで自動コンパイルする

記述例：[makefile](apb2spi/tb/makefile)

# 注意
サンプルとして使用した[apb2spi](https://opencores.org/projects/apb2spi/)をQuestaデコンパイルする場合、
[defines.v](apb2spi/tb/defines.v)が不足しているため、作成が必要
