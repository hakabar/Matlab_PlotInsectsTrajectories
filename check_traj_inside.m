%Function to control if the path tracked is inside the test section or not.
%If trajectory is outside test section it can be due to an artifact (dust,
%insect outside the Wind Tunnel,...) or that the calibration is not valid
%anymore.

function check_traj_inside(objID, objXYZ, lim_x, lim_y, lim_z)
    Ix= find(objXYZ(:,1) < lim_x & objXYZ(:,2) > -lim_x);
    Iy= find(objXYZ(:,2) < lim_y & objXYZ(:,2) > -lim_y);         
    Iz= find(objXYZ(:,3) < lim_z & objXYZ(:,3) > -lim_z);
    if Ix > 0 | Iy > 0 | Iz> 0
        disp(strcat(' * Outside the Test Section, ObjID: ',num2str(objID)));
    else
        disp(strcat(' * Inside the Test Section, ObjID: ',num2str(objID)));
    end;