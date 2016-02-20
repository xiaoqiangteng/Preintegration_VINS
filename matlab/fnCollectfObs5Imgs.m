function [FeatureObs] = fnCollectfObs5Imgs( kfids, pid, imgdir, sigma_uov_real, FeatureObs )
    global InertialDelta_options Data_config

            if(InertialDelta_options.bMalaga == 1)
                load( sprintf('%sImage%d.mat', imgdir, pid ) );
%                 obsfeatures{pid} = Image(2:end, 1:3);
                fidset = Image(2:end, 1);
                
            elseif(InertialDelta_options.bDinuka == 1)
                
                imid = kfids(pid);%1+(pid-1)*kfspan);
                load( sprintf( '%simage_%d.mat', imgdir, imid ) );
%                 obsfeatures{pid} = features;
                fidset = features(:, 1);            
                
            end

            temp = num2cell( [FeatureObs(fidset).nObs] + 1 );
            [ FeatureObs(fidset).nObs ] = temp{:};
            
            for(fidx=1:size(fidset,1))                
                
                fid = fidset(fidx);
                                
                nObs = FeatureObs(fid).nObs;
                FeatureObs(fid).obsv(nObs).pid = pid;
                
                if(InertialDelta_options.bMalaga == 1)                    
                    
                    FeatureObs(fid).obsv(nObs).uv = Image(fidx+1, 2:3);                    
                    
                elseif(InertialDelta_options.bDinuka == 1)                    
                    
                    FeatureObs(fid).obsv(nObs).uv = features(fidx, 2:3) + ...
                        fnGenGaussNoise(1, 2, sigma_uov_real);                                                        
                end
                
            end
            