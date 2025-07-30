% One layer model example

function one_layer(hbt, SD, oxy_sim_all)
    [mu_a, mu_a_s, mu_a_d] = mu_a_calculation(hbt, oxy_sim_all);
    src_coor = [50, 45];
    det_coor = [50, src_coor(2)+SD];
    unit = 1;
    det_rad = 1;
    r = SD;
    dmua = mu_a_s - mu_a_d;
    
    cfg.nphoton=5e5;
    cfg.vol=uint8(ones(100,100,100));
    %cfg.vol(:,:,10:end)=2;    % add an inclusion
    cfg.issrcfrom0=1;
    cfg.srcpos = [src_coor(1)/unit, src_coor(2)/unit, 0]+1;
    cfg.srcdir=[0 0 1];
    cfg.detpos = [det_coor(1)/unit+1, det_coor(2)/unit+1,...
            ones(size(det_coor,1),1)*(0+1), ones(size(det_coor,1),1)*(det_rad/unit)];
    cfg.vol(:,:,1)=0;   % pad a layer of 0s to get diffuse reflectance
    cfg.issaveref=1;
    cfg.gpuid=1;
    cfg.autopilot=1;
    cfg.tstart=0;
    cfg.tend=5e-9;
    cfg.tstep=5e-10;    
    cfg.prop=[0 0 1 1
        mu_a(1,1) 11.1852 0.9 1.4];
    [~,detpt]=mcxlabcl(cfg);
    
    for i = 1:5
    %Iterating over mu_a
        cfg.prop = [0 0 1 1
            mu_a(1,i) 11.1852 0.9 1.4];
        %dewt1=mcxdetweight(detpt, cfg.prop); % weight
        L_780_measured(i) = mcxmeanpath(detpt, cfg.prop);
        L_780_analytical(i) = (1.5) * (r^2) * (1.11852)./((r*sqrt(3 * mu_a(1,i) * 1.11852))+1);
    end
    
    cfg.prop=[0 0 1 1
        mu_a(2,1) 11.1852 0.9 1.4];
    
    for i = 1:5
    %Iterating over mu_a
    cfg.prop = [0 0 1 1
        mu_a(2,i) 11.1852 0.9 1.4];
        %dewt2=mcxdetweight(detphoton, cfg.prop); % weight
        L_850_measured(i) = mcxmeanpath(detpt, cfg.prop);  
        L_850_analytical(i) = (1.5) * (r^2) * (1.11852)./(r*sqrt(3 * mu_a(2,i) * 1.11852)+1);
    end
    
    for i = 1:5
        I_780_d(i) = sum(exp(-mu_a_d(1,i) * detpt.ppath(:,1)));
        I_780_s(i) = sum(exp(-mu_a_s(1,i) * detpt.ppath(:,1)));
        I_850_d(i) = sum(exp(-mu_a_d(2,i) * detpt.ppath(:,1)));
        I_850_s(i) = sum(exp(-mu_a_s(2,i) * detpt.ppath(:,1)));
    end
    
    dOD_780 = log(I_780_d ./ I_780_s);
    dOD_850 = log(I_850_d ./ I_850_s);
        
    dOD_ratio = dOD_780 ./ dOD_850;
    mul = dmua(2,:) ./ dmua(1,:);
    
    L_ratio_measured = dOD_ratio .* mul;
    
    L_ratio_direct= L_780_measured./L_850_measured;
    
    L_ratio_analytical = L_780_analytical ./ L_850_analytical;
    
    plot(oxy_sim_all,L_ratio_measured, "LineStyle","-")
    hold on;
    plot(oxy_sim_all,L_ratio_direct,"LineStyle","-.")
    hold on;
    plot(oxy_sim_all,L_ratio_analytical, "LineStyle","-.")
    hold off;
end