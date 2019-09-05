%INFO:  HDF5 files can contain data and metadata, called attributes. 
%       In an HDF5 file, the directories in the hierarchy are called groups. 
%            - A group can contain other groups, data sets, attributes, links, and data types. 
%            - A data set is a collection of data, such as a multidimensional numeric array or string. 
%            - An attribute is any data that is associated with another entity, such as a data set. 
%            - A link is similar to a UNIX file system symbolic link. Links are a way to reference objects without having to make a copy of the object.

%FLYDRA HDF% files:
% - /data2d_distorted and /cam_info tables: Tables with the raw 2D data files
% - /kalman_estimatesand and /ML_estimates tables (in additionto a /calibration group) contains the “Kalmanized” 3D data files.

%NOTES:
% - Flydra can consider each time it find an insect as a new one, even if it
%   is always the same insect 
% - Working with HALF VIDEO ONLY, to reduce loading times


% ---- MAIN CODE FOR MOSQUITO PROJECT   ---

%CLOSE ALL THE EXISTING GRAPHS AND CLEAN THE WORKSPACE
close all;
clear variables;

%test section X,Y,Z limits (start_x= -lim_x and end_x= +lim_x --> Total x distance is lim_x*2)
%These lim values are the current size of the Test Section (DO NOT CHANGE IT)
lim_x= 0.9144;
lim_y= 0.3048;
lim_z= 0.3048;

%Information related to the data to analyze
file= 'mosquito_20190719_134756.mainbrain.h5';
%file= 'mosquito_20190719_104313.mainbrain.h5';
loadFullDataset=true;
fps=90.0;

%Lower time threshold (in seconds) to plot a trajectory or not
flightTimeLimit= 3

%Load all the information from the h5 file
[attr_id, attr_frame, attr_x, attr_y, attr_z]= load_data_from_file(file, loadFullDataset);

%Plot the amount of insects detected per frame
%insects_in_frame(attr_frame)

%Plot the insects ID regarding the frames where they appear
%frames_with_insect(attr_frame, attr_id)

%Plot the  the deltaX, deltaY and deltaY between frames
plot_step_XYZ_sizes(attr_x, attr_y, attr_z)

%Create the test section in the plot to add the mosquito paths
testSectionVol= load_test_section_volumen();

%Pick the trajectory of a given insect and plot it
uniqueID=unique(attr_id);
%Transpose from a column matrix to a row matrix
uniqueID=uniqueID';
totalTraj=0;     %trajectories (over 0.5 sec) counter

trajectories= [57, 53, 73, 143, 222];
colors= ['r', 'b','g','m','c'];
for objID= trajectories%uniqueID()
    %Load the frames where appears the current objID
    objFrame= attr_id(:,1) == objID;
    %estimate the duration of the flight
    framesLen=nnz(objFrame()==1);
    duration=framesLen/fps;
    
    %Plot only if flight duration is bigger than 0.5 seconds
    if duration >= flightTimeLimit
        totalTraj= totalTraj+1;
        %Load the XYZ values for the current objID
        objXYZ=[attr_x(objFrame,:), attr_y(objFrame,:), attr_z(objFrame,:)];
        %Check if trajectory is located inside the Test Section
        check_traj_inside(objID, objXYZ, lim_x, lim_y, lim_z)
        %Plot the path of the current objID
        plot_trajectory_3D(objID, objXYZ, duration, testSectionVol, colors(totalTraj))
    end;
end;
disp(strcat(' * Total amount of flights over 0.5 seconds: ',num2str(totalTraj)));

%Plot all the trajectories together??? check testH5file_flydra_v3.m, but
%not sure if it will show relevant information.




