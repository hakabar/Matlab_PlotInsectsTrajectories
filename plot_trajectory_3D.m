
%Function to plot a given insect trajectory
%Arguments: 
%   - id: ID value for the insect trajectory to plot
%   - objXYZ: trajectory of the insect (XYZ position over time)

function plot_trajectory_3D(id, objXYZ, duration, testSectionVol, color)

    %Create the test section in the plot to add the mosquito paths
    %testSectionVol= load_test_section_volumen();
    figure(testSectionVol);
    hold on
    %Plot the XYZ values of the current objID
    plot3(objXYZ(:,1),objXYZ(:,2),objXYZ(:,3), 'Color',color)
            
    %Mark the initial position for current objID
    plot3(objXYZ(1,1),objXYZ(1,2),objXYZ(1,3),'-o', 'Color', color);
        
    %Mark the last position for current objID
    plot3(objXYZ(end,1),objXYZ(end,2),objXYZ(end,3),'-x', 'Color',color);
    
    hold off
  %  grid on;
    
  %  legend(strcat('objectID: ', num2str(id)));
    %title(strcat('Full path tracked with flydrafor insect id: ', num2str(id)));
    title(strcat('Path tracked with flydra for 5 insects (Duration between 3 and 5 sec)'));
    xlabel('X axis');
    ylabel('Y axis');
    zlabel('Z axis');
    %dim = [0.65, 0.1, 0.1, 0.1];
    %str = strcat('Duration of the flight: ',num2str(duration));
    %annotation('textbox',dim,'String',str,'FitBoxToText','on');
end