
%Function to load the insect ID its XYZ values and the frames
%Arguments: 
%   - file: Path/name of the h5 file
%   - loadFullDataset: Boolean flag to check if we want to work with the
%   full dataset or only the first half
%Returns: object ids, frame numbers and X,Y,Z positions

function [attr_id, attr_frame, attr_x, attr_y, attr_z]= load_data_from_file(file, loadFullDataset)

    location_ML='/ML_estimates';   %dataset name where the attributes are contained
    location_KA='/kalman_estimates';   %dataset name where the attributes are contained

    % from the DATASET ML_estimates and kalman_estimates 
    %I will read the attributes frame, x y and z to plot them
    dataset= h5read(file,location_KA'); 

    %halfSize=length(dataset.frame);
    if loadFullDataset == true
        %Load the full dataset
        disp(' * Loading full dataset');
        attr_frame=dataset.frame;
        attr_x=dataset.x;
        attr_y=dataset.y;
        attr_z=dataset.z;     %values are NaN until row 2220
        attr_id= dataset.obj_id(:);
    else
        %Load only the first half of the dataset
        disp(' * Loading only the first half of the dataset');
        halfSize= ceil(length(dataset.frame)/2);   %load half dataset
        attr_frame=dataset.frame(1:halfSize);
        attr_x=dataset.x(1:halfSize);
        attr_y=dataset.y(1:halfSize);
        attr_z=dataset.z(1:halfSize);     %values are NaN until row 2220
        attr_id= dataset.obj_id(1:halfSize);
    end;
end