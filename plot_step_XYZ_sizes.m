
%function to plot the deltaX, deltaY and deltaY between frames
%(how big is the step between frames for each axis)

%WARNING: - Some variations values are bigger than the limits set in the Y axis axis, 
%         but the yLim() allows us to see the small changes. 
%         - To see the full variation between positions, comment the ylim()
%         lines

function plot_step_XYZ_sizes(attr_x, attr_y, attr_z)
    figure(3)
    subplot(3,1,1);
    plot(diff(attr_x),'b');
    title('Plot step variation for X axis');
    xlabel('Frame number');
    ylim([-5 5]);
    ylabel('step variation');
    subplot(3,1,2);
    plot(diff(attr_y),'r');
    title('Plot step variation for Y axis');
    xlabel('Frame number');
    ylim([-5 5]);
    ylabel('step variation');
    subplot(3,1,3);
    plot(diff(attr_z),'g');
    title('Plot step variation for Z axis');
    xlabel('Frame number');
    ylim([-5 5]);
    ylabel('step variation');
    disp(' * Plot Y axis have been limited between -5 and 5.')
    disp(strcat('   - Biggest step variation between frames in the X axis: ',num2str(max(attr_x))))
    disp(strcat('   - Biggest step variation between frames in the Y axis: ',num2str(max(attr_x))))
    disp(strcat('   - Biggest step variation between frames in the Z axis: ',num2str(max(attr_z))))
end