function Z_obj = InertialDelta_CreateZ( nPoseNew, nPts )
    global InertialDelta_options
    
    UV_Def = struct( ...
        'uv',   zeros( 2, 1 ), ...
        'row', [] ...
        );

    
    % Firstly allocate a maximal space.
    if(InertialDelta_options.bPreInt == 1)
        %Zobs = zeros(2*nPts*nPoseNew+9*(nPoseNew-1), 1);            
        DeltaP_Def = struct( ...
            'val', zeros( 3, 1 ), ...
            'row', [] ...
            );
        
        DeltaV_Def = struct( ...
            'val', zeros( 3, 1 ), ...
            'row', [] ...
            );
        
        DeltaPhi_Def = struct( ...
            'val', zeros( 3, 1 ), ...
            'row', [] ...
            );
        
        IntlDelta_Def = struct ( ...
            'deltaP',   DeltaP_Def, ...
            'deltaV',   DeltaV_Def, ...
            'deltaPhi', DeltaPhi_Def ...
            );
        
        Angle_Def = struct( ...
            'val', zeros(3, 1), ...
            'row', [] ...
            );
        
        Trans_Def = struct( ...
            'val', zeros(3, 1), ...
            'row', [] ...
            );
        
        Bf_Def = struct( ...
            'val', zeros(3, 1), ...
            'row', [] ...
            );
        
        Bw_Def = struct( ...
            'val', zeros(3, 1), ...
            'row', [] ...
            );
        
        Z_Def = struct( ...
            'fObs',         repmat( UV_Def, nPts * nPoseNew, 1 ), ... % maybe redundant, will be cleaned
            'intlDelta',    repmat( IntlDelta_Def, nPoseNew-1, 1 ), ...
            'Au2c',         Angle_Def, ...
            'Tu2c',         Trans_Def, ...
            'Bf',           Bf_Def, ...
            'Bw',           Bw_Def ...
            );
        
    else
        
        %Zobs = zeros(2*nPts*nPoseNew+9*(nPoseNew-1), 1);
        IMU_Def = struct ( ...
            'acc',      zeros( 3, 1 ), ...
            'angRate',  zeros( 3, 1 ) ...
            );
        Z_Def = struct( ...
            'uv',       repmat( UV_Def, nPts * nPoseNew, 1 ), ... % maybe redundant, will be cleaned
            'imu',      repmat( IMU_Def, nPoseNew-1, 1 ), ...
            'Au2c',     zeros(3, 1), ...
            'Tu2c',     zeros(3, 1), ...
            'Bf',       zeros(3, 1), ...
            'Bw',       zeros(3, 1) ...
            );
    end
    
    Z_obj = Z_Def;
