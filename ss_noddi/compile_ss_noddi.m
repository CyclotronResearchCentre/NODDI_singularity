function compile_ss_noddi()
% Siya Sherif, Martin Grignard, and Christophe Phillips. 2021.
% NODDI processsing using singularity
% Create a runtime compiler for the NODDI toolbox
% This is fucntion compiles the main function 
% Require MATLAB 2020b, Runtime Compiler v99 (older version should also work, I havent tested it) 
% june 2021 : version 1.0 
% -------------------------------------------------------------------------
% Copyrigh @ GIGA CRC ULiege 

% download the NODDI_toolbox_v1.04 and nifti_matlab

% addpath to tthe path  
addpath(genpath('/path-to-/NODDI_toolbox_v1.04/'));
addpath(genpath('/path-to/nifti_matlab/'));

% makes sure to remove all other add path before compilation 

% define input file and out directory (pwd since I am runing this in the current directory) 
appFile = fullfile(pwd,'ss_noddi.m');
OutDir  = fullfile(pwd,'ss_noddi_App');

% compile and create standalone app. Require MATLAB 2020b, Runtime Compiler v99 
% older version could use "mcc". I havent tested it. If you are testing other versions 
% don't forget to select the right matlab compiler version)

buildRes=compiler.build.standaloneApplication(appFile,...
    'OutputDir',OutDir);


end