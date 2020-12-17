%% ABRIMOS LOS DIRECTORIOS
root_dir = pwd;
w_f = uigetdir(pwd,'Escoger el directorio w_f del paciente:');
fast = uigetdir(pwd,'Escoger el directorio fast del paciente:');
eyes = uigetdir(pwd,'Escoger el directorio eyes del paciente:');
subj_path = uigetdir(pwd,'Escoger el directorio del paciente:');

cd(subj_path);

%% Abrimos todas las segmentaciones
model = load_nii(fullfile(w_f,'181031_w_f_1.nii'));
model.img = double(model.img);

gm = load_nii(fullfile(fast,'181031_gm.nii'));
gm.img = double(gm.img);

wm = load_nii(fullfile(fast,'181031_wm.nii'));
wm.img = double(wm.img);

csf = load_nii(fullfile(fast,'181031_csf.nii'));
csf.img = double(csf.img);

eyes = load_nii(fullfile(eyes,'181031_eyes.nii'));
eyes.img = double(eyes.img);
%% Unimos las clases

HEAD = model.img;

HEAD = (HEAD.*~csf.img) + 3*csf.img;
HEAD = (HEAD.*~gm.img) + 4*gm.img;
HEAD = (HEAD.*~wm.img) + 5*wm.img;
HEAD = (HEAD.*~eyes.img) + 6*eyes.img;

model.img = HEAD;

view_nii(model)
%% Guardamos el atlas completo

save_nii(model,fullfile(subj_path,'181031_mask2.nii.gz'))
