# NODDI singularity
Singularity containerized version of the NODDI toolbox. [NODDI matlab toolbox](http://mig.cs.ucl.ac.uk/index.php?n=Tutorial.NODDImatlab) is a MatLab based toolbox developed by Prof Gary Zang for fitting NODDI data. Since the tool requires MatLab, it cannot be deplyed on High-Performance Computing (HPC) clusters that do not have MatLab installed on it. This NODDI singularity container provides an alternative option to run NODDI without MATLAB and can be readily deployed in most HCP clusters. For this container, we are using the single thread option of the NODDI matlab toolbox because the Parallel Computing Toolbox implementation requires an additional Matlab licence. The single thread version takes more than the parallel version. However, this delay could be compensated when deployed in HPC where many images could be processed in parallel. (Eg. NODDI processing using Parallel Computing Toolbox to fit NODDI data with 220454 voxels in local machine using 8 parallel core takes ~ 3 hours. Thats 300 Hours for 100 subjets. The single thread version takes ~18 hours per subject. However, 100 subjects could be launched parallely in the HCP parallely.)

### Authors
- Siya Sherif, `s.sherif_at_uliege.be`
- Martin Grignard, `mar.grignard_at_uliege.be`
- Christophe Phillips, `c.phillips_at_uliege.be`



# To create NODDI container 

The container can be built locally on a machine where Singularity is available 

    singularity build noddi-singularity.sif singularity-ss-noddi.def

The singularity image can be dowloaded from [OSF](https://osf.io/m2w6y/)

cite us, if you use the container
```
Zhang, H., Schneider, T., Wheeler-Kingshott, C. A., & Alexander, D. C. (2012). NODDI: practical in vivo neurite orientation dispersion and density imaging of the human brain. NeuroImage, 61(4), 1000–1016.

Sherif, S., Grignard, M., & Phillips, C. (2021, July 5). noddi-singularity. Retrieved from osf.io/m2w6y
```

# Run the container 

General format to run the script is 

```
singularity run --cleanenv \
    --bind <path_to_noddi_input_folder>:/In_fold \
    <path_to_singulairty_image_folder>/noddi-singularity.sif \
    /In_fold/<NODDI image> \
    /In_fold/<brain_mask> \
    /In_fold/<NODDI_roi> \
    /In_fold/<bval> \
    /In_fold/<bvecs> \
    /In_fold/<FittedParams.mat>
    /in_fold/<output_map>
```

Example 
    
To run the [NODDI example dataset](http://mig.cs.ucl.ac.uk/index.php?n=Tutorial.NODDImatlab)

Download the dataset from this above link 

```
singularity run --cleanenv \
    --bind /<path_to_noddi_folder>/NODDI_example_dataset:/In_fold \
    /<path_to_singulairty_image_folder>/noddi-singularity.sif \
    /In_fold/NODDI_DWI.hdr \
    /In_fold/roi_mask.hdr \
    /In_fold/NODDI_roi.mat\
    /In_fold/NODDI_protocol.bval \
    /In_fold/NODDI_protocol.bvec \
    /In_fold/FittedParams.mat
    /in_fold/example
```


