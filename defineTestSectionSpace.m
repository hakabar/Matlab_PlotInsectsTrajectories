% Script to load only the first (x,y,z) position for each objID. This is
% use when using a blinking LED in several points of the test section to
% check if FLYDRA consider correctly the insect position and its real
% position in the wind tunnel.

% As I was keeping the LED steady, only the first XYZ point for each objID
% is needed (the other points are due to my hand movement)

file1= 'testWithLED_4.mainbrain.h5';
%file1= '20190701_132429.mainbrain.h5';
%test section X,Y,Z limits (start_x= -lim_x and end_x= +lim_x)
lim_x= 0.9144;
lim_y= 0.3048;
lim_z= 0.3048;

location_ML='/ML_estimates';   %dataset name where the attributes are contained
location_KA='/kalman_estimates';   %dataset name where the attributes are contained

% from the DATASET ML_estimates and kalman_estimates 
%I will read the attributes frame, x y and z to plot them
%dataset= h5read(file1,location_ML') 
dataset= h5read(file1,location_KA'); 

attr_frame=dataset.frame();
attr_x=dataset.x();
attr_y=dataset.y();
attr_z=dataset.z();     %values are NaN until row 2220
attr_id= dataset.obj_id();

%Erase all the points taken, but located outside the test section
indices = find(abs(attr_x)>lim_x);
attr_x(indices) = NaN;
indices = find(abs(attr_y)>lim_y);
attr_y(indices) = NaN;
indices = find(abs(attr_z)>lim_z);
attr_z(indices) = NaN;



%Count the number of frames where each obj_id appears
aux=accumarray(attr_id, 1);
uniqueID=unique(attr_id).';


%Create an stimation of where the fixed point where in the test section
%(regarding the datapoints)
fixed_x=linspace(-0.9144, 0.9144, 7);
fixed_y=linspace(-0.3048, 0.3048, 3);
fixed_z=linspace(-0.3048, 0.3048, 3);

auxX1(1:length(fixed_y))=fixed_x(1);
auxX3(1:length(fixed_y))=fixed_x(7);
auxY1(1:length(fixed_x))=fixed_y(1);
auxY3(1:length(fixed_x))=fixed_y(3);
auxZ1(1:length(fixed_x))=fixed_z(1);
auxZ3(1:length(fixed_x))=fixed_z(3);


%Plot the (x,y) 1st positions for each ObjID
figure
objID=uniqueID(1);
objFrame= attr_id(:,1) == objID;
%plot3(attr_x(objFrame(1,1),1), attr_y(objFrame(1,1),1), attr_z(objFrame(1,1),1),'*r');
plot(attr_x(objFrame(1,1),1), attr_y(objFrame(1,1),1),'^b');
hold on
for objID= uniqueID(2:length(uniqueID)-1)
    objFrame= attr_id(:,1) == objID;
    objXYZ=[attr_x(objFrame,:), attr_y(objFrame,:), attr_z(objFrame,:)];
    plot(objXYZ(1,1),objXYZ(1,2),'*r');
    %plot3(attr_x(objFrame(1,1),1), attr_y(objFrame(1,1),1), attr_z(objFrame(1,1),1),'*r');

end
objID= uniqueID(length(uniqueID));
objFrame= attr_id(:,1) == objID;
objXYZ=[attr_x(objFrame,:), attr_y(objFrame,:), attr_z(objFrame,:)];
plot(objXYZ(1,1),objXYZ(1,2),'vg');
%for i= fixed_y(1:3)
%    plot(fixed_x, i, '+k'); 
%end
%Plot the marks where the point where taken
plot(fixed_x, fixed_y(1), '+k'); 
plot([fixed_x(1), fixed_x(4), fixed_x(7)], fixed_y(2), '+k'); 
plot(fixed_x, fixed_y(3), '+k'); 
plot(attr_x(objFrame(1,1),1), attr_y(objFrame(1,1),1),'^b');

hold off
grid on
title('fixed positions in Test Section (X-Y axis only)');
xlabel('X axis');
ylabel('Y axis');
%ylim(-0.4, 0.4, 0.05);


figure
%load the borders of the test section
plot3(fixed_x(1), fixed_y(1), fixed_z(1), 'k');
hold on
plot3(fixed_x, auxY1, auxZ1, 'k'); 
plot3(fixed_x, auxY3, auxZ1, 'k'); 
plot3(fixed_x, auxY1, auxZ3, 'k'); 
plot3(fixed_x, auxY3, auxZ3, 'k'); 
plot3(auxX1, fixed_y, [fixed_z(1),fixed_z(1),fixed_z(1)], 'k'); 
plot3(auxX1, fixed_y, [fixed_z(3),fixed_z(3),fixed_z(3)], 'k');
plot3(auxX3, fixed_y, [fixed_z(1),fixed_z(1),fixed_z(1)], 'k'); 
plot3(auxX3, fixed_y, [fixed_z(3),fixed_z(3),fixed_z(3)], 'k');
plot3(auxX1, [fixed_y(1),fixed_y(1),fixed_y(1)], fixed_z, 'k'); 
plot3(auxX1, [fixed_y(3),fixed_y(3),fixed_y(3)], fixed_z, 'k');
plot3(auxX3, [fixed_y(1),fixed_y(1),fixed_y(1)], fixed_z, 'k'); 
plot3(auxX3, [fixed_y(3),fixed_y(3),fixed_y(3)], fixed_z, 'k');

%Load the 1st point detected for each ObjID
objID=uniqueID(1);
fstObjFrame= attr_id(:,1) == objID;
%First point (plotted as blue ^)
plot3(attr_x(fstObjFrame(1,1),1), attr_y(fstObjFrame(1,1),1), attr_z(fstObjFrame(1,1),1),'^b');
for objID= uniqueID(2:length(uniqueID)-1)
    %For each ObjID, plot the 1sp point detected only 
    objFrame= attr_id(:,1) == objID;
    objXYZ=[attr_x(objFrame,:), attr_y(objFrame,:), attr_z(objFrame,:)];
    plot3(objXYZ(1,1),objXYZ(1,2), objXYZ(1,3),'*r');
end
%Last point (plotted as green v)
objID= uniqueID(length(uniqueID));
objFrame= attr_id(:,1) == objID;
objXYZ=[attr_x(objFrame,:), attr_y(objFrame,:), attr_z(objFrame,:)];
plot3(objXYZ(1,1),objXYZ(1,2), objXYZ(1,3),'vg');

%Plot the marks where the points where taken
%plot3(fixed_x(1), fixed_y(1), fixed_z(1), '+k');
plot3(fixed_x, fixed_y(1), fixed_z(1), '+k'); 
plot3([fixed_x(1), fixed_x(4), fixed_x(7)], fixed_y(2), fixed_z(1), '+k'); 
plot3(fixed_x, fixed_y(3), fixed_z(1), '+k'); 
%plot3(fixed_x, fixed_y(1), fixed_z(3), '+k'); 
%plot3(fixed_x, fixed_y(3), fixed_z(3), '+k');
hold off
grid on
title('fixed positions in Test Section (XYZ axis)');