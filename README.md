# NODDI singularity
Singularity containerized version of the NODDI toolbox.


### Authors
- Siya Sherif, `s.sherif_at_uliege.be`
- Martin Grignard, `mar.grignard_at_uliege.be`
- Christophe Phillips, `c.phillips_at_uliege.be`

# To create NODDI container 

The container can be built locally on a machine where Singularity is available 

    singularity build noddi-singularity.sif singularity-ss-noddi.def

The singularity image can be dowloaded from [OSF](https://osf.io/m2w6y/)

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

Download the dataset from the above page 

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


