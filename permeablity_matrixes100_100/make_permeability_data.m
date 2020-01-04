% sgems_sgsim_conditional_hard_data_from_file : 
%     Conditional SGSIM using hard data from file

% GET Default par file
S=sgems_get_par('sgsim');
pix= 100
% Define observed data=
d_obs=[18 13 0 2; 5 5 0 -1; 50 40 1 0];
% note that the third observation is located outside the 2D simluation plane! 
sgems_write_pointset('obs.sgems',d_obs);
S.f_obs='obs.sgems';
S.x=1:100
S.y = 1:100
S.dim.nx = pix
S.dim.ny = pix
S.XML.parameters.Max_Conditioning_Data.value=18;
S.XML.parameters.Nb_Realizations.value=100;
S.XML.parameters.Variogram.structure_1.ranges.max=30;
S.XML.parameters.Variogram.structure_1.ranges.medium=30;
S.XML.parameters.Variogram.structure_1.ranges.min=30;
S=sgems_grid(S);

%% PLOT DATA
figure
cax=[0 2];
for i=1:(min([100 S.XML.parameters.Nb_Realizations.value]));
  subplot(10,10,i);
  imagesc(S.x,S.y,S.D(:,:,1,i)');axis image;caxis(cax);title(sprintf('SIM#=%d',i))
end
for i = 1 : S.XML.parameters.Nb_Realizations.value
    b{i} = S.D(:,:,1,i)'
end

x =1:50
y = 1:50
[x,y] =meshgrid(x,y)
xi = linspace(1,50,100)
yi = linspace(1,50,100)
[xi,yi] = meshgrid(xi,yi)
for i = 1:S.XML.parameters.Nb_Realizations.value
    c{i} = interp2(x,y,b{i},xi,yi,'cubic')+2
end

rand_collection=cell(1,800) 
counter = 1
for i = 1:S.XML.parameters.Nb_Realizations.value
    rand_collection{counter} = c{i};
    counter = counter +1
    rand_collection{counter} = imrotate(c{i},90);
    counter = counter +1
    rand_collection{counter} = imrotate(c{i},180);
    counter = counter +1
    rand_collection{counter} = imrotate(c{i},270);
    counter = counter +1
    rand_collection{counter} = flip(c{i},1);
    counter = counter +1
    rand_collection{counter} = flip(c{i},2);
    counter = counter +1
    rand_collection{counter} = flip(imrotate(c{i},90),1);
    counter = counter +1
    rand_collection{counter} = flip(imrotate(c{i},270),1);
    counter = counter +1
end

%随机图片
ran = randperm(800)
rand_collection = rand_collection(ran)
 
%%  
% %% 90度 -> 上下翻转
% I90sn = flip(imrotate(c{2},90),1)
% imshow(I90sn)
% figure
% I270we = flip(imrotate(c{2},270),1)
%     counter = counter +1
% 
% 
% 
% figure
% imshow(c{2})
% %% 旋转功能
% figure
% I90=imrotate(c{2},90)
% imshow(I90)
% figure
% I180=imrotate(c{2},180)
% imshow(I180)
% figure
% I270=imrotate(c{2},270)
% imshow(I270)
% figure
% 
% %% 垂直水平翻转
% Ins = flip(c{2},1)
% imshow(Ins)
% figure
% Iew = flip(c{2},2)
% imshow(Iew)
% figure
% 
% %% 90度 -> 上下翻转
% I90sn = flip(imrotate(c{2},90),1)
% imshow(I90sn)
% figure
% I270we = flip(imrotate(c{2},270),1)
% imshow(I270we)
% 
% 
% 

%% scale
%perm to 101*101
counter  = 1 
for i = 1:S.XML.parameters.Nb_Realizations.value*8
    rand_collection{counter} = rand_collection{counter}/4*100;
    rand_collection{counter}(101,:) = rand_collection{counter}(100,:);
    rand_collection{counter}(:,101) =rand_collection{counter}(:,100);
    counter = counter +1
    try1 = reshape(rand_collection{i},1,10201)
    try2 = reshape(try1(1:end-1),6,1700)
    perm100{i} = abs(try2')
end
    
counter  = 1 
for i = 1:S.XML.parameters.Nb_Realizations.value*8
    rand_collection{counter} = rand_collection{counter}/4*200;
    rand_collection{counter}(101,:) = rand_collection{counter}(100,:);
    rand_collection{counter}(:,101) =rand_collection{counter}(:,100);
    counter = counter +1
    try1 = reshape(rand_collection{i},1,10201)
    try2 = reshape(try1(1:end-1),6,1700)
    perm200{i} = abs(try2')
end

counter  = 1 
for i = 1:S.XML.parameters.Nb_Realizations.value*8
    rand_collection{counter} = rand_collection{counter}/4*300;
    rand_collection{counter}(101,:) = rand_collection{counter}(100,:);
    rand_collection{counter}(:,101) =rand_collection{counter}(:,100);
    counter = counter +1
    try1 = reshape(rand_collection{i},1,10201)
    try2 = reshape(try1(1:end-1),6,1700)
   perm300{i} = abs(try2')
end


counter  = 1 
for i = 1:S.XML.parameters.Nb_Realizations.value*8
    rand_collection{counter} = rand_collection{counter}/4*400;
    rand_collection{counter}(101,:) = rand_collection{counter}(100,:);
    rand_collection{counter}(:,101) =rand_collection{counter}(:,100);
    counter = counter +1
    try1 = reshape(rand_collection{i},1,10201)
    try2 = reshape(try1(1:end-1),6,1700)
    perm400{i} = abs(try2')
end

%%write to txt



fid1=['write_txt','.txt'];%创建新的txt文件
fid = fopen('write_txt', 'wt');
mat = perm100{1};
for i = 1:size(mat, 1)
    fprintf(fid, '%f\t', mat(i,:));
    fprintf(fid, '\n');
end
fprintf(fid,'%f\n',perm100{1}(end,end))
fclose(fid);


fn = 'write_txt';
fid = fopen(fn,'r');
R = [];
while ~feof(fid)
    tl = fgetl(fid);
    id = findstr(tl,'63.157117');
    if ~isempty(id)
        dt = tl(id+3:id+10);
        dt = strtok(dt);
        R = [R; str2num(dt)];     
    end;
end;
disp(R);





