# PODB：: A learning-based polarimetric object detection benchmark for road scenes in adverse weather conditions

Here is the official repository : [repository_link](https://github.com/zhuz-bit/PODB/tree/main)
## We share our work in three parts: **Dataset**, **Framework**, and **Evaluation**.

----------------------------------------------------------------------------------------------------------------
1. :heartpulse: [First of All](#first-of-all)

2. :star: [Dataset](#dataset)

3. :fire:  [Framework](#framework)

4. :strawberry:  [Evaluation](#evaluation)

5. :fried_shrimp: [Citation](#citation)

# **First of All**
The polarimetric imaging technique has demonstrated significant advantages when handling object detection in road scenes. In adverse weather conditions, polarization imaging selectively receives and analyzes the vibration direction and intensity of light under different polarization directions, providing information about surface material properties, textures, and shapes, reducing interference from haze particles, suppressing scattering from media particles, and eliminating interference from raindrops and snowflakes, thus providing richer and more accurate image information.

<div align=center>
<img src="https://github.com/zhuz-bit/PODB/blob/main/paper/image555.png" width="520px">
</div>

This study introduces the Polarized Object Detection Benchmark (PODB), a benchmark dataset that incorporates the physical dimension of optical polarization imaging to tackle object detection challenges in complex road scenes under adverse weather conditions. It specifically includes the establishment of a large-scale polarization dataset, the proposal of an enhanced detection model, and extensive algorithm evaluation.

<div align=center>
<img src="https://github.com/zhuz-bit/PODB/blob/main/paper/image3.png" width="520px">
</div>

To address issues such as poor object recognition accuracy under adverse weather conditions and the underutilization of the significant advantages of polarization imaging, we propose a Physics-based Multi-scale Image Fusion Cascaded Object Detection Neural Network model (PMIF-CODNN).

<div align=center>
<img src="https://github.com/zhuz-bit/PODB/blob/main/paper/image15.png" width="520px">
</div>

The proposed PODB aims to furnish researchers with an effective platform for the assessment and comparison of object detection algorithms, as well as provide researchers with a baseline for future studies in developing new DL-based methods, ultimately contributing to advancements in this field.

<div align=center>
<img src="https://github.com/zhuz-bit/PODB/blob/main/paper/image000.png" width="520px">
</div>

----------------------------------------------------------------------------------------------------------------


# **Dataset**
The link to the RAW images of the PODB dataset is: [dataset_link](https://pan.baidu.com/s/1B2KEE0b5c9HsTerZb5PLGA?pwd=1x2s)

As the first large-scale benchmark polarized dataset specifically tailored for object detection in adverse weather conditions in road scenes, the proposed PODB encompasses 12 different adverse weather conditions, 8 types of road scenes, and 3 subsets of preprocessed images. It also annotates tens of thousands of object detection positions and category information in a large-scale real polarized target dataset. 

**Specifically, the PODB dataset is obtained by capturing real raw image data under different adverse weather conditions using a color focal plane polarization camera (LUCID-PHX050S-PC@2048x2448 , Sensor size is 11.1 mm (Type 2/3”), with a frame rate of 22 FPS (24 FPS) @ 5.0 MP, and a pixel size of 3.45μm(H) x 3.45μm(V); with a lens of M2514-MP2 25 mm f/1.4).**

```
|-- rawbegin
  |-- polar
    |-- 0
    |-- 45
    |-- 90
    |-- 135
    |-- AoP
    |-- DoLP
    |-- S0
    |-- S1
    |-- S2
    ...
  |-- out
    |-- 1.raw
    |-- 2.raw
    ...
```
In addition, we provide demo code for solving and reading Raw images. 

:candy: [**raw_stokes_get.m**](https://github.com/zhuz-bit/PODB/blob/main/preprocess/raw_stokes_get.m) ; :ice_cream: [**read_raw.m**](https://github.com/zhuz-bit/PODB/blob/main/preprocess/read_raw.m)


----------------------------------------------------------------------------------------------------------------
# **Framework**

We propose a Physics-based Multi-scale Image Fusion Cascaded Object Detection Neural Network model (PMIF-CODNN). It incorporates a multi-scale fusion module and a multi-decision adaptive attention mechanism, where the polarization-guided multi-scale image fusion technique effectively aggregates features by extracting and merging polarization and intensity images.

<div align=center>
<img src="https://github.com/zhuz-bit/PODB/blob/main/paper/image88.png" width="520px">
</div>

----------------------------------------------------------------------------------------------------------------
# **Evaluation**
The fundamental evaluation criteria for algorithms lack uniformity and tend to be subjective. Consequently, it becomes necessary to incorporate multiple indicators into the evaluation process to circumvent the constraints imposed by relying solely on a single metric;


General object datasets encompass a diverse range of object classes, which inherently increases the complexity of learning. However, they may not adequately capture object characteristics under adverse weather conditions. Consequently, only a select few pre-trained models exhibit consistently superior performance on the PODB dataset in comparison to their performance on the COCO dataset;


In complex adverse weather conditions, the utilization of polarimetric imaging, which offers a multitude of modalities, proves to be more effective in characterizing objects under conditions of low light and intense reflections when contrasted with traditional sensors.

<div align=center>
<img src="https://github.com/zhuz-bit/PODB/blob/main/paper/plot.png" width="520px">
</div>

**************************************************************************
# **Citation**

If you use this benchmark dataset in your research, please cite this project.

```
@article{zhu2024podb,
  title={PODB: A learning-based polarimetric object detection benchmark for road scenes in adverse weather conditions},
  author={Zhu, Zhen and Li, Xiaobo and Zhai, Jingsheng and Hu, Haofeng},
  journal={Information Fusion},
  pages={102385},
  year={2024},
  publisher={Elsevier}
}
```
**************************************************************************


