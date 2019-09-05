%CLOSE ALL THE EXISTING GRAPHS AND CLEAN THE WORKSPACE
close all;
clear variables;

%test section X,Y,Z limits (start_x= -lim_x and end_x= +lim_x --> Total x distance is lim_x*2)
%These lim values are the current size of the Test Section (DO NOT CHANGE IT)
lim_x= 0.9144;
lim_y= 0.3048;
lim_z= 0.3048;

%Information related to the data to analyze
%file= 'mosquito_20190719_104313.mainbrain.h5';
file= 'mosquito_20190719_134756.mainbrain.h5';
%file= 'mosquito_20190720_160334.mainbrain.h5';
loadFullDataset=true;
fps=90.0;

%Load all the information from the h5 file
[attr_id, attr_frame, attr_x, attr_y, attr_z]= load_data_from_file(file, loadFullDataset);

%Pick the trajectory of a given insect and plot it
uniqueID=unique(attr_id);
%Transpose from a column matrix to a row matrix
uniqueID=uniqueID';
totalTraj=0;    

%xy= figure
figure
subplot(2,1,1);
title('(X,Y) view of the test section');
xlabel('X axis');
ylabel('Y axis');
%grid on;
hold on;
%yz= figure
subplot(2,1,2);
title('(X,Z) view of the test section');
xlabel('X axis');
ylabel('Z axis');
%grid on;
hold on;
trajectories= [57, 53, 73, 143, 222];
colors= ['r', 'b','g','m','c']

for objID= trajectories %uniqueID()
    %Load the frames where appears the current objID
    objFrame= attr_id(:,1) == objID;
    %estimate the duration of the flight
    framesLen=nnz(objFrame()==1);
    duration=framesLen/fps;
    
    %Plot only if flight duration is bigger than 0.5 seconds
    if (duration >= 3 && objID ~= 192)
        totalTraj= totalTraj+1;
        %Load the XYZ values for the current objID
        objXYZ=[attr_x(objFrame,:), attr_y(objFrame,:), attr_z(objFrame,:)];
        subplot(2,1,1);      
        plot(objXYZ(:,1), objXYZ(:,2), 'Color',colors(totalTraj))
        subplot(2,1,2);
        plot(objXYZ(:,1), objXYZ(:,3), 'Color',colors(totalTraj))        
        disp(strcat(' * objID over 3 seconds: ',num2str(objID)));
        
    end;
end;
hold off
hold off
disp(strcat(' * Total amount of flights over 0.5 seconds: ',num2str(totalTraj)));
