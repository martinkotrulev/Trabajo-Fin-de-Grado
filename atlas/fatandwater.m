%% ABRIMOS LOS DIRECTORIOS
root_dir = pwd;
subj_path = uigetdir(pwd,'Escoger el directorio del paciente:');
cd(subj_path);

%% ABRIMOS LAS IMÁGENES IN,F y W
img_IN = load_nii(fullfile(subj_path,'181031_IN_1.nii'));
img_F = load_nii(fullfile(subj_path,'181031_F_1.nii'));
img_W = load_nii(fullfile(subj_path,'181031_W_1.nii'));

img_IN.img = double(img_IN.img);
img_F.img = double(img_F.img);
img_W.img = double(img_W.img);
%% CREAMOS MÁSCARA BINARIA

img_IN.img = img_IN.img >= 2.5*mean(img_IN.img(:));
img_IN.img = bwlabeln(img_IN.img);
[counts,centers] = hist(img_IN.img(:),unique(img_IN.img(:)));
counts(1) = 0;
img_IN.img = double(img_IN.img == centers(counts==max(counts)));
%% SEGMENTAMOS AGUA Y GRASA

[x,y,z] = size(img_IN.img);
for idx=1:x
    for idy=1:y
        for idz=1:z
            if img_IN.img(idx,idy,idz) == 1
                if img_F.img(idx,idy,idz) > img_W.img(idx,idy,idz)
                    img_IN.img(idx,idy,idz) = 1;
                else
                    img_IN.img(idx,idy,idz) = 2;
                end
            end
        end
    end
end
save_nii(img_IN,fullfile(subj_path,'181031_w_f_1.nii.gz'))
view_nii(img_IN);
