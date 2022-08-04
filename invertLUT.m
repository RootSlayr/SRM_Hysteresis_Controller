function LUT_currentMatrix = invertLUT(angleArray, currentArray, fluxlinkMatrix)
    %size(angleArray) => [N_angles, 1]
    %size(currentArray) => [N_current, 1]
    %size(fluxlinkMatrix) => [N_angles, N_current]
    N_angles = length(angleArray);
    N_fluxlink = N_angles;
    
    LUT_currentMatrix = zeros(N_angles, N_fluxlink);
    targetArray = linspace(min(fluxlinkMatrix(:)),max(fluxlinkMatrix(:)),N_fluxlink);
    current_max = max(currentArray);
     
    for i_angle = 1:N_angles
        fluxlink_row = fluxlinkMatrix(i_angle,:);
        %all flux linkages for given angle from max to min
        for i_fluxlink = 1:N_fluxlink
            TARGET = targetArray(i_fluxlink);
            %flux linkages we want to determine the current for 
            
            if TARGET > max(i_fluxlink)
                LUT_currentMatrix(i_angle, i_fluxlink) = current_max ; %saturation functin
            else 
                LUT_currentMatrix(i_angle, i_fluxlink) = ...
                interp1(fluxlink_row, currentArray, TARGET);    %lookup content
            end
        end
    end
    %contour3( currentArray,angleArray,LUT_currentMatrix,size(LUT_currentMatrix(:)));
end