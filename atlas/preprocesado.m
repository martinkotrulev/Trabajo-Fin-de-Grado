%% ABRIMOS LOS DIRECTORIOS
root_dir = pwd;
subj_path = uigetdir(pwd,'Escoger el directorio del paciente:');
cd(subj_path);

%% LEEMOS LA IMÁGEN NIFTI
HEAD= load_nii(fullfile(subj_path,'181026_2_IN.nii'));
view_nii(HEAD)
%% RECORTAMOS LA IMÁGEN NIFTI

HEAD.img = HEAD.img(60:131, 40:111, 100:161);

HEAD.hdr.dime.dim(2) = size(HEAD.img,1);
HEAD.hdr.dime.dim(3) = size(HEAD.img,2);
HEAD.hdr.dime.dim(4) = size(HEAD.img,3);

HEAD.hdr.hist.originator(1) = HEAD.hdr.hist.originator(1)-(60);
HEAD.hdr.hist.originator(2) = HEAD.hdr.hist.originator(2)-(40);
HEAD.hdr.hist.originator(3) = HEAD.hdr.hist.originator(3)-(95);

view_nii(HEAD);
%% GUARDAMOS LA NUEVA IMÁGEN
save_nii(HEAD,fullfile(subj_path,'181031_W_1.nii.gz'))
