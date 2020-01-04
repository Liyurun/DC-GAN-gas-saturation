import os
import numpy as np
import re
import sys
import os.path
import scipy.io as scio

def list_file(path):
    count = 0
    filename_list =[]
    for filename in os.listdir(path):
        if os.path.splitext(filename)[1] == '.out':
            count = count+1
            print(filename)
            filename_list.append(filename)
    print('total csv file: ',count)
    return filename_list

if __name__=="__main__":
    filename_list = list_file(os.getcwd())
    print(filename_list)

    num_out_file = len(filename_list)
    # every out file
    all_data = []
    for file_num in range(0,len(filename_list)):
        f = open(filename_list[file_num])

        lines = f.readlines()

        lines_num  = len(lines)

        print(lines[4])
        print(lines_num)
        time_step_num = 0
        str1 = '                                                           Gas Saturation\n'
        time_step_num = 0
        part_num = 8
        part_len = 101
        aa=[]
        for i in range(0,lines_num):
            line = lines[i]
        # print(lines[i])
            if line == str1:
                time_step_num += 1
                if time_step_num == 1:
                    pass
                else:
                    part1 = lines[i+4:i+part_len+4]
                    part2 = lines[i+part_len+6:i+2*part_len+6]
                    part3 = lines[i+2*part_len+8:i+3*part_len+8]
                    part4 = lines[i+3*part_len+10:i+4*part_len+10]
                    part5 = lines[i+4*part_len+12:i+5*part_len+12]
                    part6 = lines[i+5*part_len+14:i+6*part_len+14]
                    part7 = lines[i+6*part_len+16:i+7*part_len+16]
                    part8 = lines[i+7*part_len+18:i+8*part_len+18]
                    h1 = []
                    h2 = []
                    h3 = []
                    h4 = []
                    h5 = []
                    h6 = []
                    h7 = []
                    h8 = []
                    start_point = 2
                    for j in range(0,101):
                        t1 = part1[j].replace('=',' ').split()
                        h1.append(t1[start_point:])
                    for j in range(0,101):
                        t2 = part2[j].replace('=',' ').split()
                        h2.append(t2[start_point:])
                    for j in range(0,101):
                        t3 = part3[j].replace('=',' ').split()
                        h3.append(t3[start_point:])
                    for j in range(0,101):
                        t4 = part4[j].replace('=',' ').split()
                        h4.append(t4[start_point:])
                    for j in range(0,101):
                        t5 = part5[j].replace('=',' ').split()
                        h5.append(t5[start_point:])
                    for j in range(0,101):
                        t6 = part6[j].replace('=',' ').split()
                        h6.append(t6[start_point:])
                    for j in range(0,101):
                        t7 = part7[j].replace('=',' ').split()
                        h7.append(t7[start_point:])
                    for j in range(0,101):
                        t8 = part8[j].replace('=',' ').split()
                        h8.append(t8[start_point:])
                    if time_step_num <= 2:
                        t1 = np.hstack((h1,h2,h3,h4,h5,h6,h7,h8))
                        aa.append(t1.tolist())
                    else:
                        t2 = np.hstack((h1,h2,h3,h4,h5,h6,h7,h8))
                        aa.append(t2.tolist())
                        
                        

        all_data.append(aa)
        if file_num%1 == 0:
            save_str = 'asd'+filename_list[file_num].strip('.out')+'.mat'
            scio.savemat(save_str,{'all_data':all_data})
            #data = scio.loadmat('asd.mat')
            del all_data
            print('finish-',str(file_num/50))
            all_data=[]
