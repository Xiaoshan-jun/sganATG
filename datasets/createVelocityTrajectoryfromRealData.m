%fileID = fopen('datasets/real/train/train.txt','w');
%fileID = fopen('datasets/real/val/val.txt','w');
%fileID = fopen('datasets/real/vis/vis.txt','w');
%fileID = fopen('plot.txt','w');
agentcount = 0;
t = 0;
b = 0.1;
fileID = fopen('velocity/traindata.txt','w');
%fileID = fopen('realdata2/prompt.txt','w');
%fileID = fopen('realdata2/valdata.txt','w');
for i = 0:80
    r = rem( i , 10 );
    if r == 8 
        continue;
    end
    if r == 9
        continue;
    end
    if i == 70
        continue;
    end
    filename = sprintf('realdata2/flightdata%d.csv', i);
    %filename2 = sprintf('realdata/valdata%d.txt', i);
    %fileID = fopen(filename2,'w');
    %fileID = fopen('plot.txt','w');
    T = readtable(filename);
    T = table2array(T);
    for k = 1:size(T)
    T(k, 1) = round(T(k, 1),1);
    end
    a = size(T);
    tn = a(1);
    tn = floor(tn);
    half = tn/2;
    for j = 1 : 1
%             historyx = [];
%             historyy =[];
%             historyz =[];
        count = 0;
        sumx = 0;
        sumy = 0;
        sumz = 0;
        t = T(1,1);
        first = 1;
        for k = 1:tn
            
            newt = T(floor(k), 1);
            if newt == t
                count = count + 1;

                sumx = sumx + T(k, 2);
                sumy = sumy + T(k, 3);
                sumz = sumz + T(k,4);
            else
                if first == 1
                    h = 'new';
                    first = 0;
                elseif k <= half
                    h = 'past';
                else
                    h = 'future';
                end
                x = round(sumx/count,4);
                y = round(sumy/count,4);
                z = round(sumz/count,4);
                count = 1;
                sumx = T(k,2);
                sumy = T(k,3);
                sumz = T(k,4);
                fprintf(fileID,'%s\t%2.1f\t%4.4f\t%4.4f\t%4.4f\n',h, t,x,y,z);
                
%             historyx(k) =  x;
%             historyy(k) =y;
%             historyz(k) =z;
            end
            t = newt;
        end
%             figure(1)
%             scatter3(historyx, historyy, historyz)
%             plot3(historyx, historyy, historyz, 'o-')
%             title("real landing", 'FontSize', 14)
%             xlabel('x', 'FontSize', 14)
%             ylabel('y', 'FontSize', 14)
%             zlabel('z', 'FontSize', 14)
    end
end

% str = sprintf('real20.png');
% print(gcf,str,'-dpng','-r900'); 
fclose(fileID);
%%
clc
clear all
%filename = sprintf('realdata/automatic/flightdata%d.csv', 17);
filename = sprintf('realdata/flightdata%d.csv', 61);
T = readtable('realdata/flightdata0.csv');
a = size(T);

for i = 1:a
    x = table2array(T(i, 2));
    y = table2array(T(i, 3));
    z = table2array(T(i, 4));
    historyx(i) =  x;
    historyy(i) =y;
    historyz(i) =z;
end
figure(1)
scatter3(historyx, historyy, historyz)
plot3(historyx, historyy, historyz, 'o-')

