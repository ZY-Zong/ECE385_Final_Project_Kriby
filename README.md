The final project of ECE385.

# Authors
* Zhenyu Zong (zhenyu.17@intl.zju.edu.cn)
* Kaiwei Sun (kaiwei.17@intl.zju.edu.cn)

# Description
This project reproduces the GBA game **Kirby & The Amazing Mirror** using  FPGA DE2-115 board. Due to the
limit size of OCM, we only put three enemies, kirby and one map inside it.

# Features
* NIOS II CPU core
  * Game logic control
  * USB device
* OCM
  * VGA display
  * 3.888 Mbit memory
  * Store image files, support up to four sprites including Kirby
* SDRAM
  * Software program

# References
* [The Spriters Resource](https://www.spriters-resource.com/game_boy_advance/kirbyandtheamazingmirror/) provides image sources.
* [Aseprite](https://www.aseprite.org/) is a quite powerful pixelart tool, highly recommended.
