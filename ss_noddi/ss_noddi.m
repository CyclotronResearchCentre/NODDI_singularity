function ss_noddi(NODDI_DWI,brain_mask,NODDI_roi,bval,bvec,fitpar_mat,vol_par_map)
% Siya Sherif, Martin Grignard, and Christophe Phillips. 2021.
% NODDI processsing using singularity
% Create a runtime compiler for the NODDI toolbox
%
% june 2021 : version 1.0 
% -------------------------------------------------------------------------
% this code requires
%
% 1. NODDI_toolbox_v1.04 :  http://mig.cs.ucl.ac.uk/index.php?n=Tutorial.NODDImatlab
% Zhang, Hui, et al. "NODDI: practical in vivo neurite orientation dispersion 
% and density imaging of the human brain." Neuroimage 61.4 (2012): 1000-1016.
%
% 2. NIFTI Matlab library: https://github.com/NIFTI-Imaging/nifti_matlab
%
% 3. MATLAB 2020b, Runtime Compiler v99 (older version should also work, I havent tested it) 
% -------------------------------------------------------------------------
% Inputs 
%
% NODDI_DWI     - DWI image
% brain mask    - ROI mask which defines the foreground voxels for model fitting
% NODDI_roi     - to save the output of the "Create ROI"   
% bval          - bval
% bvec          - bvec
% fitpar_mat    - to save the output of "FittedParams"
% vol_par_map   - to save the output of "volumetric parameter maps"
% -------------------------------------------------------------------------
% Copyright @ GIGA CRC ULiege 


% Start timer 
time_start = tic;

% unzip the DWI files 
[~,~,eddy_ext]=fileparts(NODDI_DWI);
if strcmp(eddy_ext,'.gz')
    aa = gunzip(NODDI_DWI);
    NODDI_DWI = aa{1};
end

% unzip the brain mask 
[~,~,mask_ext]=fileparts(brain_mask);
if strcmp(mask_ext,'.gz')
    bb = gunzip(brain_mask);
    brain_mask = bb{1};
end

% need to remove the SPM path (NODDI recommends it). 
% rmpath(genpath(spm('Dir'))) % remove SPM path 

% remove all other paths other than the require ones  

% uncomment if you want to test it locally. 
% addpath(genpath('/media/siya/CRC_DATA_ss/test_octave/ss_noddi/NODDI_toolbox_v1.04/'));
% addpath(genpath('/media/siya/CRC_DATA_ss/test_octave/ss_noddi/nifti_matlab/'));

% create ROI
CreateROI(NODDI_DWI,brain_mask,NODDI_roi);

% protocol 
protocol = FSL2Protocol(bval,bvec);

% model 
noddi = MakeModel('WatsonSHStickTortIsoV_B0');

% fitting
batch_fitting_single(NODDI_roi,protocol,noddi,fitpar_mat);

% save : Convert the estimated NODDI parameters into volumetric parameter maps 
SaveParamsAsNIfTI(fitpar_mat, NODDI_roi, brain_mask,vol_par_map);

time_stop = toc(time_start);

end