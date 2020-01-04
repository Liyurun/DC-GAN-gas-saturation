file_path = pwd
img_path_list = dir(strcat(file_path,'/*.jpg'));%获取该文件夹中所有jpg格式的图像

for i = 1:length(img_path_list)
    test = imread(img_path_list(i).name);
    test1 = label2rgb(rgb2gray(test)+1,jet(255));
    imwrite(test1,strcat('zzz',num2str(i),'.jpg'));
end

% figure
% test1 = label2rgb(rgb2gray(test)+1,jet(255))
% 
% real1 = label2rgb(rgb2gray(real)+1,jet(255))
