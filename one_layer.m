% One layer model example
function one_layer(hbt, sd, thick)
    cfg.prop=[0 0 1 1
        mu_a(1,1) 11.1852 0.9 1.4];
    [~,detpt]=mcxlabcl(cfg);

    for i = 1:5
    %Iterating over mu_a
        cfg.prop = [0 0 1 1
            mu_a(1,i) 11.1852 0.9 1.4];
        L = mcxmeanpath(detpt, cfg.prop);
        dewt1=mcxdetweight(detpt, cfg.prop);
        L_780_measured(:,i) = L';
        %L_850_measured(i) = mcxmeanpath(detphoton, cfg.prop);
    end

    cfg.prop=[0 0 1 1
        mu_a(2,1) 11.1852 0.9 1.4];

    for i = 1:5
    %Iterating over mu_a
    cfg.prop = [0 0 1 1
        mu_a(2,i) 11.1852 0.9 1.4];
    
    
        % Calculate the measured L
        %L_780_measured(i) = mcxmeanpath(detphoton, cfg.prop);
        L = mcxmeanpath(detphoton, cfg.prop);
        dewt2=mcxdetweight(detphoton, cfg.prop);
        L_850_measured(:,i) = L';   
    end
end