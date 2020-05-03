%number     time    x    y     num¡¢
day = 400
    for i = 1:800
        eval(strcat('load ',strcat(' asdCMG',num2str(i))))
            for j = 1:101
                for l = 1:101
                    m = size(all_data(1,day,j,l,:));
                    t(i,j,l) = str2num(reshape(all_data(1,day,j,l,:),1,m(end)));
                end
            end
            i
        clear strd
        h = reshape(t(i,:,:),101,101);
        str2 = strcat('satur',num2str(i),'.jpg');
        imwrite(h,str2);
    end