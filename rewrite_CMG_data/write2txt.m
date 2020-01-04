
%% read and write


% stable part
fidin1 = fopen('first_part.txt','r')
    j = 1;
        while ~feof(fidin1)
            temp10{j}=fgetl(fidin1);
            j=j+1;
        end


fidin2=fopen('back.txt','r');
        i=1;
        while ~feof(fidin2)
            temp20{i}=fgetl(fidin2);
            i=i+1;
        end

% 前半部分   
for num = 1:800
    fn = strcat('CMG',num2str(num),'.dat');
    fopen(fn,'a');
    fid = fopen(fn,'r+');
    
    for i=1:size(temp10,2)
        fprintf(fid,'%s\n',temp10{i});
    end
    fclose(fidin1);
    
    mat = perm100{num};
            for i = 1:size(mat, 1)
                fprintf(fid, '%f\t', mat(i,:));
                fprintf(fid, '\n');
            end
    fprintf(fid,'%f\n',perm100{num}(end,end));
    
    
%     while ~feof(fid)
%         tl = fgetl(fid);
%         id = findstr(tl,'PERMI');
%         if ~isempty(id)
%             fprintf(fid,'\n');
%             mat = perm100{num};
%             for i = 1:size(mat, 1)
%                 fprintf(fid, '%f\t', mat(i,:));
%                 fprintf(fid, '\n');
%             end
%             fprintf(fid,'%f\n',perm100{num}(end,end));
%         end
%     end

    for i=1:size(temp20,2)
        fprintf(fid,'%s\n',temp20{i});
    end
    fclose(fid);

end
fclose(fidin2);



%% build up bat


fileFolder=fullfile('E:\我的资料\深层\数模\code\mGstat\mGstat-0.995\examples\sgems_examples\write2txt')
 
dirOutput=dir(fullfile(fileFolder,'*.dat'))
 
fileNames={dirOutput.name}

for j = 1:8
    for i = 100*(j-1)+1:length(fileNames)
       mat1{j,i-(j-1)*100} = strcat('CALL "gm201710.exe" -f "',fileNames{i},'"  -doms -parasol 8')
    end
    name = strcat('run',num2str(j),'.bat')
    fid = fopen(name,'w')
    for k = 1:100
        fprintf(fid,mat1{j,k})
        fprintf(fid,'\n')
    end
    fprintf(fid,'exit')
    fclose(fid)
    
end







